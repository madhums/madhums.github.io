---
layout: post
categories: [javascript, localstorage]
title: localStorage manager (lm.js)
keywords: javascript, localStorage
summary: localStorage manager (lm.js) - A simple wrapper around `localStorage` with which you can store, query and perform CRUD operations on collections and documents.
github: https://github.com/madhums/lm.js
---

localStorage manager (lm.js) is a simple wrapper around `localStorage` with which you can store, query and perform CRUD operations on collections and documents in an easy way.

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

    console.log(doc.name);
    // undefined
  });
});
```

To use it, just source `lm.js` in your app.

## Tests

You can see the test results on [travis-ci](https://travis-ci.org/madhums/lm.js)

## Limitations

Localstorage has a limitation of 5MB, so if you want to use offline data storage with files etc, [indexedDB](http://hacks.mozilla.org/2012/02/storing-images-and-files-in-indexeddb/) would be a good option.

### Resources:

* [lm.js on github](https://github.com/madhums/lm.js)
