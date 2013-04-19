---
layout: post
categories: [passport.js, authentication, mongoose]
tumblr_id: 27702878857
date: 2012-07-21 16:44:00 UTC
title: Passportjs, everyauth and mongoose-auth
keywords: passport.js, mongoose-auth, everyauth
summary: Passport.js is much better than mongoose auth in handling authentication as it is completely database agnostic
github: https://github.com/madhums/nodejs-express-mongoose-demo
---

Today I am trying out [passport.js](https://github.com/jaredhanson/passport) and I am really thinking of  discontinuing mongoose-auth/everyauth in all of my projects! Everyauth and mongoose-auth are awesome modules but they are not database agnostic. In that sense passportjs is very flexible and  database agnostic. Its like omniauth for rails, which I am sure the [author](http://twitter.com/jaredhanson) would have thought of while developing.

The next post will be on converting an app built on everyauth to passportjs (with express v3). I will convert the app demoed in my previous post to express 3.0.0beta7 and passport.js

---

So I did convert my demo to express3, mongoose3 and passport. Take a
look at the [source](https://github.com/madhums/nodejs-express-mongoose-demo) and the [website](http://nodejs-express-demo.herokuapp.com/)
