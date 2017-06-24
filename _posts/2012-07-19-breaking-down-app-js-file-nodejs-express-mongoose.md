---
layout: post
title: Structuring express.js applications
description: Breaking down app.js
keywords: node.js, express.js, mongoose
categories: [mongoose, pagination]
---

A working draft of the app architecture is in progress, visit the boilerplate [wiki](https://github.com/madhums/node-express-mongoose/wiki)

Ok, this post is long overdue!

**tl;dr** : _This blog post explains how to structure and organize your node.js application. Its an anatomy of [nodejs-express-demo](http://nodejs-express-demo.herokuapp.com) app_

The [demo](http://nodejs-express-demo.herokuapp.com) app illustrates the following

1. MVC architecture using express
2. Custom error handling in express
3. Routing in express
4. CRUD operations using mongoose ODM
5. dbref and populate using mongoose ODM
6. use of flash variables (displaying messaages like "updated successfully" etc)
7. dynamic helpers
8. user authentication using facebook
9. validations
10. embedded documents in mongoose
11. route middlewares in express
12. using of middlewares in mongoose
13. deployment on heroku
14. Managing multiple environments (development, staging and production)
15. and many more...


A year back I started working on [node.js](http://nodejs.org) and like always I started with a CRUD app. The examples and sample applications that were available were mostly single page apps (written in  a single file `server.js` or `app.js`). After going through dozens of sample apps and express [examples](https://github.com/visionmedia/express/tree/master/examples), I came up with this folder structure.

![folder structure](http://f.cl.ly/items/2W3c451O2c2I071U2p11/Image%202012.07.18%2011:58:11%20PM.png)

Also, being a rails developer, it was quite easy to think about the way your app has to be structured and organized.

Before going further, the demo app is a blog application where users (signing up using facebook) can create an article, delete an article and comment on an article.

Modules used

1.   [Express](http://expressjs.com/) (who doesn't know express!)
2.   [Mongoose](http://github.com/LearnBoost/mongoose) (ODM for mongodb)
3.   [Jade](https://github.com/visionmedia/jade/) (views templating engine)
4.   [Mongoose-auth](https://github.com/bnoguchi/mongoose-auth#readme) (authentication plugin for mongoose)
5.   [Everyauth](http://everyauth.com/) (auth package (password, facebook, & more) for Connect and Express apps)

## Anatomy of app.js file
The app.js file does all the bootstrapping by `require`-ing all the controllers, models and middlewares.

```js
/* Main application entry file. Please note, the order of loading is important.
 * Configuration loading and booting of controllers and custom error handlers */

var express = require('express')
  , fs = require('fs')
  , utils = require('./lib/utils')
  , auth = require('./authorization')

// Load configurations
var config_file = require('yaml-config')
exports = module.exports = config = config_file.readConfig('config/config.yaml')

require('./db-connect')                // Bootstrap db connection

// Bootstrap models
var models_path = __dirname + '/app/models'
  , model_files = fs.readdirSync(models_path)
model_files.forEach(function (file) {
  if (file == 'user.js')
    User = require(models_path+'/'+file)
  else
    require(models_path+'/'+file)
})

var app = express.createServer()       // express app
require('./settings').boot(app)        // Bootstrap application settings

// Bootstrap controllers
var controllers_path = __dirname + '/app/controllers'
  , controller_files = fs.readdirSync(controllers_path)
controller_files.forEach(function (file) {
  require(controllers_path+'/'+file)(app)
})

require('./error-handler').boot(app)   // Bootstrap custom error handler
mongooseAuth.helpExpress(app)          // Add in Dynamic View Helpers
everyauth.helpExpress(app, { userAlias: 'current_user' })

// Start the app by listening on <port>
var port = process.env.PORT || 3000
app.listen(port)
console.log('Express app started on port '+port)
```

As you can see, we can break the app.js into 5 parts. Bootstrapping

1. Config (`./config/config.yaml`)
2. Models (`./app/models/`)
3. Controllers (`./app/controllers/`)
4. Settings (`./settings.js`)
5. Error handlers and other helpers (`./error-handlers.js`)

## 1. config `./config/config.yaml`
The config file holds environment specific settings. Based on NODE_ENV the corresponding config is chosen. So I am using `yaml-config` module for loading this, you can also use a simple json file or js file exporting the required configs.

You can also use [npm config](http://npmjs.org/doc/config.html).

## 2. Models `./app/models/`
The model files contain the schema, methods, pre-save hooks, pre-delete hooks, validations and other background processing stuff.

```js
// Article schema

var ArticleSchema = new Schema({
    title       : {type : String, default : '', trim : true}
  , body        : {type : String, default : '', trim : true}
  , user        : {type : Schema.ObjectId, ref : 'User'}
  , created_at  : {type : Date, default : Date.now}
})

ArticleSchema.path('title').validate(function (title) {
  return title.length > 0
}, 'Article title cannot be blank')

ArticleSchema.path('body').validate(function (body) {
  return body.length > 0
}, 'Article body cannot be blank')

ArticleSchema.pre('save', function (next) {
  // do something before you save...
  next()
})

ArticleSchema.methods.uploadPhotos = function (file, callback) {
  // upload photos
  callback(uploadedFIle)
})

mongoose.model('Article', ArticleSchema)
```

As you can see `user` here is a ref field (like a foreign key). If you want to load this field, then you need to use populate.

```js
Article
  .findOne({ title: 'abc' })
  .populate('user')
  .run(function (err, article) {
    // do something
    // article.user would be populated with fields in user schema
  })
```

There are many other awesome stuff mongoose provides. Do take a look at mongoose [tests](https://github.com/LearnBoost/mongoose/tree/master/test) and the [documentation](http://mongoosejs.com/).

## 3. Controllers `./app/controllers/`
The controller files contain the routes, routing middlewares, business logic, template rendering and dispatching.

```js
module.exports = function(app, auth){

  // Edit an article
  app.get('/article/:id/edit', auth.requiresLogin, auth.article.hasAuthorization, function(req, res){
    res.render('articles/edit', {
      title: 'Edit '+req.article.title,
      article: req.article
    })
  })

  // Delete an article
  app.del('/article/:id', auth.requiresLogin, auth.article.hasAuthorization, function(req, res){
    var article = req.article
    article.remove(function(err){
      // req.flash('notice', 'Deleted successfully')
      res.redirect('/articles')
    })
  })
}
```

As you can see, the articles controller is passed with `app` and `auth` arguments. Here, auth is used as routing middleware. If you take a look at `./authorization.js`, each function is a routing middleware. Based on type of user and requested article, you can control the authorization using the routing middleware.

## 4. Settings `./settings.js`
The settings file deals with express specific settings. It sets the view engine, some dynamic view helpers and other environment specific settings.

```js
app.configure(function(){

  // set views path, template engine and default layout
  app.set('views', __dirname + '/app/views')
  app.set('view engine', 'jade')
  app.set('view options', { layout: 'layouts/default' })

  // contentFor & content view helper - to include blocks of content only on required pages
  app.use(function(req, res, next){
    // expose the current path as a view local
    res.local('path', url.parse(req.url).pathname)

    // assign content str for section
    res.local('contentFor', function(section, str){
      res.local(section, str)
    })

    // check if the section is defined and return accordingly
    res.local('content', function(section){
      if (typeof res.local(section) != 'undefined')
        return res.local(section)
      else
        return ''
    })
    next()
  })

  // bodyParser should be above methodOverride
  app.use(express.bodyParser())
  app.use(express.methodOverride())

  // cookieParser should be above session
  app.use(express.cookieParser())
  app.use(express.session({
    secret: 'noobjs',
    store: new mongoStore({
      url: config.db.uri,
      collection : 'sessions'
    })
  }))

  app.use(express.favicon())

  // routes should be at the last
  // app.use(app.router)
  app.use(mongooseAuth.middleware())
})

// Some dynamic view helpers
app.dynamicHelpers({
  request: function(req){
    return req
  },

  hasMessages: function(req){
    if (!req.session) return false
    return Object.keys(req.session.flash || {}).length
  },

  // flash messages
  messages: require('./lib/express-messages'),

  // dateformat helper. Thanks to gh-/loopj/commonjs-date-formatting
  dateformat: function(req, res) {
    return require('./lib/dateformat').strftime
  }
})

// show error on screen. False for all envs except development
// settmgs for custom error handlers
app.set('showStackError', false)

// configure environments
app.configure('development', function(){
  app.set('showStackError', true)
  app.use(express.static(__dirname + '/public'))
})

// gzip only in staging and production envs
app.configure('staging', function(){
  app.use(gzippo.staticGzip(__dirname + '/public'))
  app.enable('view cache')
})

app.configure('production', function(){
  app.use(gzippo.staticGzip(__dirname + '/public'))
  // view cache is enabled by default in production mode
})

app.use(express.logger(':method :url :status'))
```

**Please note that the order of `use`-ing middlewares is very important!**

## 5. Error handlers `./error-handler.js`
The error handler file handles the 404 and 500 errors by rendering a template. If you check the `views` folder, you can see there are 2 templates, one for 404 and the other for 500 errors.

## Views `./app/views/`
The demo app uses [jade](http://jade-lang.com/) as template engine. The views are organized quite similar to rails. There is a `./app/views/layouts` folder which contains the default layout within which our templates will be rendered. There is an `includes` folder which includes the common parts of the page (like footer, header). There are pretty cool helpers like `contentFor()` etc - similar to the one in rails, do check out the `./settings.js` file.

**Flash messages**
I am using [express messages](http://github.com/visionmedia/express-messages) to generate flash messages. All you need to do is set req.flash in your controller
`req.flash('notice', 'Created successfully')` and in your template, just use `!= messages()`

The current demo app uses [twitter bootstrap](http://twitter.github.com/bootstrap) for UI, if you checkout the earlier commits/tags, you can use [stylus](http://learnboost.github.com/stylus/).

## Migrating express from 2.x to 3.x + Node 0.6.x to 0.8.x
Express 3.x is in beta, anytime now we can expect a stable release (and even mongoose, which is in 3.x). I am starting a migration branch and also planning to blog about the changes/issues I face during the migration process.

**Update:** The demo has been updated to use all the latest modules. More authentications have been added using passport.js. Do take a look at the source!

_If you want to build an app from scratch using this approach, use the [boilerplate app](https://github.com/madhums/node-express-mongoose/)_

---

## Resources:

* [demo site](http://nodejs-express-demo.herokuapp.com)
* [source code on github](http://github.com/madhums/nodejs-express-mongoose-demo)
