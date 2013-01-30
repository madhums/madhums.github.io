---
layout: post
categories: [javascript, localstorage]
title: localStorage manager
keywords: javascript, localStorage
summary: localStorage manager (lm.js) - a simple way to store, manipulate and perform queries on collections and documents in your localStorage.
---

When you are developing applications for mobile, say using phonegap, jQtouch or backbone, you would want to query collections, manipulate documents, updating, removing or adding a new one. This library allows you to play around with collections and documents in an easy way.

You should be able to do something like this.

## Initialize your app

```js
var todoapp = new lm('todoapp');
```

## Create a collection

```js
// create collection
var list = todoapp.create('todos');
```

or create an initialized collection

```js
var todosList = [
  { id: 1, name: 'shopping' },
  { id: 2, name: 'washing' }
];
var list = todoapp.create('todos', todosList);
```

## Add records to collection

```js
// create collection
var list = todoapp.create('todos');

// add records to collection
list.add({ name: 'shopping' });
```

## Chain them

```js
var archived = todoapp
  .create('archived')
  .add({ name: 'shopping', tag: 'outside' })
  .add({ name: 'eating', tag: 'kitchen' })
  .add({ name: 'bathing', tag: 'inside' })
  .add({ name: 'cleaning', tag: 'kitchen' });
```

## Remove a collection

```js
// remove a collection
todoapp.remove('todos');
```

## Retrieve a collection

```js
// get collection
var archived = todoapp.get('archived');
```

## Find within a collection

```js
// currently accepts only one criteria
archived.find({ tag: 'kitchen' }, function (docs) {
  console.log(docs);
  // output:
  // [{ name: 'eating', tag: 'kitchen' }, { name: 'cleaning', tag: 'kitchen' }]
});
```

## Update a document within a collection

```js
archived.find({ tag: 'kitchen' }, function (docs) {
  docs.find({ name: 'eating' }, function (records) {
    var doc = records[0]; // { name: 'eating', tag: 'kitchen' }

    doc.update({ name: 'cutting' });

    console.log(doc); // { name: 'cutting', tag: 'kitchen' }
  });
});
```

## Remove a document within a collection

```js
archived.find({ tag: 'kitchen' }, function (docs) {
  docs.find({ name: 'eating' }, function (records) {
    var doc = records[0]; // { name: 'eating', tag: 'kitchen' }

    doc.remove();

    console.log(doc);
    // undefined
  });
});
```

To use it, just source `lm.js` in your app.

## Limitations

Localstorage has a limitation of 5MB, so if you want to use offline data storage with files etc, [indexedDB](http://hacks.mozilla.org/2012/02/storing-images-and-files-in-indexeddb/) would be a good option.

**Note:** Currently the `find` method accepts only one criteria.

---
### Resources:

* [lm.js source](https://github.com/madhums/lm.js)
