---
layout: post
categories: [javascript, notifier]
title: node-notifier
keywords: javascript, notifier
description: A node module for sending out notifications
github: https://github.com/madhums/node-notifier
---

One of the most common things while developing API's or web applications is that you want to notify your users about some new stuff. node-notifier is a simple module that makes notifications easy.

## Installation

```sh
$ npm install notifier
```

or include it in `package.json`

## Usage

For email notifications, you have to use (jade) templates to write the email body. By default it uses [postmarkapp](http://postmarkapp.com) to send emails (in the upcoming versions you'll be able to configure this). If you plan to not use jade, you can override the `processTemplate` method to use templating language of your choice.

```js
var notifier = new Notifier({
  APN: false, // apple push notifications
  email: true,
  actions: ['comment', 'like'], // should be the name of the template files
  tplPath: require('path').resolve(__dirname, './templates'), // path to the directory where all the templates reside
  postmarkKey: 'POSTMARK_KEY'
});

var comment = {
  to: 'Tom',
  from: 'Harry'
};

var options = {
  to: 'tom@madhums.me',
  subject: 'Harry says Hi to you',
  from: 'harry@madhums.me',
  locals: comment // should be the object containing the attributes used in the template
};

notifier.send('comment', options, function (err) {
  if (err) return console.log(err);
  console.log('Successfully sent Notifiaction!');
});
```

For APN (apple push notifications), notifier uses `parse-sdk`. Set the `APN` key to true and provide parseAPI appId and app secret. You can either do

```js
var notifier = new Notifier({
  APN: true, // apple push notifications
  actions: ['comment', 'like'], // should be the name of the templates
  parseAppId: 'APP_ID',
  parseApiKey: 'MASTER_KEY',
  parseChannels: ['USER_5093a266180b779762000005']
});
```

or if you have already an instance of `Notifier`

```js
notifier.use({
  APN: true,
  parseChannels: ['USER_5093a266180b779762000005'] // user Id of the user in your system
})

// var options = { ... }

notifier.send('comment', options, function (err) {
  if (err) return console.log(err);
  console.log('Successfully sent Notifiaction!');
});
```

---

## Resources:

* [node-notifier on github](https://github.com/madhums/node-notifier)
