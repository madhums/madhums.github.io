---
layout: post
title: Manipulate and upload images to cloud
description: A node module to resize, crop images + cloud uploads
keywords: nodejs, images, S3, amazon, rackspace, cloudfiles, imagemagick, imager
categories: [imager, uploads, javascript]
---

A Node.js module to resize, crop, manipulate images, maintain different presets of the same image and upload to rackspace cloudfiles. Its completely asynchronous.

## Installation

```sh
$ npm install imager
```

## Usage
**You need to create imager configuration file with image variants and your storages**

Below is an example config

```js
module.exports = {
  variants: {
    items: {
      resize: { mini : "300x200", preview: "800x600" },
      crop: { thumb: "200x200" },
      resizeAndCrop: { large: {resize: "1000x1000", crop: "900x900"} }
    },
  },
  storage: {
    Rackspace: {
      auth: {
        username: "USERNAME", apiKey: "API_KEY", host: "lon.auth.api.rackspacecloud.com"
      },
      container: "CONTAINER_NAME"
    }
  },
  debug: true
}
```

and then

```js
var Imager = require('imager');
  , imagerConfig = require('path/to/imager-config.js')
  , imager = new Imager(imagerConfig, 'Rackspace')
```

## Uploading file(s)

The callback recieves an err object, a files array (containing the names of the files which were uploaded) and the cdnUri.

Suppose you have a variant, say `thumb`, then you can access the image by `cdnUri+'/'+'thumb_'+files[0]`. This would be the complete url of the image

**Form upload (multiple images)**

If you are using express, you will recieve all the form files in `req.files`.

```js
imager.upload(req.files.image, function(err, cdnUri, files) {
  // do your stuff
}, 'projects')
```

Here, `projects` is your scope or variant. If you don't specify the scope or the variant, imager will try to look for a default variant named `default`. You must either specify a variant like above or provide a `default` variant.

**Upload local images**

```js
imager.upload(['/path/to/file'], function (err, cdnUri, files) {
  // do your stuff
}, 'projects')
  ```

Here files can be an array or a string. Make sure the path is absolute.

## Removing file(s)

**Remove from cloudfiles**

```js
var files = ['1330838831049.png', '1330838831049.png']
imager.remove(files, function (err) {
  // do your stuff
}, 'projects')
```

`files` can be array of filenames or a string of single filename.

Even here, if the variant is not specified, imager will try to look for the `default` variant. If neither of them are provided, you will get an error.

## Debugging
If you specify `debug: true` in the imager config, you can see the logs of uploaded / removed files.

## To-do's
* Support amazon storage
* Write more tests

---

## Resources:

* [Github source](https://github.com/madhums/node-imager)
