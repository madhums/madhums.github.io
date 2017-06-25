---
layout: post
title: Trade-offs of purely client side apps
date: 2012-10-02 16:21:52 UTC
description: Trade-offs of client side development approach
keywords: backbone.js, client, development, api
categories: [backbone.js, javascript]
---

I've been developing products on [backbone.js](http://github.com/documentcloud/backbone/) on the front end for past couple of months and I feel that the development is rather slow when compared to the server side (have you felt the same?). Here I am talking about fairly large applications in which you are working with collaborators.

I want to address a few things in this post

1. Why go with purely client side approach?
2. Trade-offs of client side approach

## Why go with purely client side approach?

1. Responsiveness
2. RESTful interface

One of the main reasons I feel like going with this approach is the **responsiveness**. If you use tools like [grunt.js](https://github.com/gruntjs/grunt), you can just have 1 css file, 1 js file and 1 image sprite (yes there is an awesome module called [node-spritesheets](https://github.com/richardbutler/node-spritesheet)) and 1 html file. The whole app resides on the  browser and its super fast and responsive! With this you'd also get to build a neat **RESTful** interface. These are the only two main advantages I see.

## Trade-offs of client side approach

1. No hard and fast conventions
2. Development time is rather slow
3. Hard to maintain

When I say convention think about the conventions that you'd follow while developing an application server side and then compare it with the conventions that you'd follow with the client side approach (forget about the designs for a moment).

One of the differences between client side approach and server side approach is that - you don't get to use tools that make your development faster. When I say tools here, it means stuff like generators etc. And there is no convention based approach, like if you place a file somewhere, it would not automatically perform something out of the box. So you need to manually wire up all the connections between these components, which also makes it a bit hard to maintain.

What I love about the js community is its a free world! You can write code however you want! (not literally) There are numerous advantages! The drawback here being the lack of conventions on how to use them with each other. Because of this, there are chances that you might end up doing a particular task in a very complex and time consuming way (as opposed to the way you'd have done if there was a convention) Of-course you can bring some conventions on a project level, that's what happens all the time but even there, its a bit hard to maintain the code - coz not everyone would write code of the same quality, simplicity. Then you end up doing code reviews.

What do you think? Do you feel the same? I would like to know about your experiences.

**Tools and libs I've been using:**

* [backbone.js](http://github.com/documentcloud/backbone/)
* [backbone.layoutmanager](http://github.com/tbranyen/backbone.layoutmanager)
* [backbone-boilerplate](http://github.com/tbranyen/backbone-boilerplate)
* [grunt-bbb](http://github.com/backbone-boilerplate/grunt-bbb)
* [twitter bootstrap](http://twitter.github.com/bootstrap)

I haven't tried any other libs like angular or meteor...
