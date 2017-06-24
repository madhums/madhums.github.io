---
layout: post
title: pagination using mongoose, express and jade
description: Pagination using mongoose, express and jade.
keywords: mongoose, express, jade, pagination
categories: [mongoose, express, jade, pagination, node.js]
---

Ok, here's how to create simple pagination using jade and mongoose.

Say you have an event model with lots of events.

```js
exports.index = function (req, res) {
  var perPage = 10
    , page = req.param('page') > 0 ? req.param('page') : 0

  Event
    .find()
    .select('name')
    .limit(perPage)
    .skip(perPage * page)
    .sort({name: 'asc'})
    .exec(function (err, events) {
      Event.count().exec(function (err, count) {
        res.render('events', {
            events: events
          , page: page
          , pages: count / perPage
        })
      })
    })
}
```

We would be using a helper method to create the pagination.

```jade
table.table
  thead
    tr
      th #
      th Name
    tbody
      each event, i in events
        tr
          td= 10 * page + (i + 1)
          td
            a(href="/admin/events/"+event.id)= event.name

if (pages > 1)
  .pagination
    ul
      != createPagination(pages, page)
```

The `createPagination` helper

```js
res.locals.createPagination = function (pages, page) {
  var url = require('url')
    , qs = require('querystring')
    , params = qs.parse(url.parse(req.url).query)
    , str = ''

  params.page = 0
  var clas = page == 0 ? "active" : "no"
  str += '<li class="'+clas+'"><a href="?'+qs.stringify(params)+'">First</a></li>'
  for (var p = 1; p < pages; p++) {
    params.page = p
    clas = page == p ? "active" : "no"
    str += '<li class="'+clas+'"><a href="?'+qs.stringify(params)+'">'+ p +'</a></li>'
  }
  params.page = --p
  clas = page == params.page ? "active" : "no"
  str += '<li class="'+clas+'"><a href="?'+qs.stringify(params)+'">Last</a></li>'

  return str
}
```

That's it!

---

## Resources:

* [Demo](http://nodejs-express-demo.herokuapp.com/)
* [Source](https://github.com/madhums/nodejs-express-mongoose-demo)
