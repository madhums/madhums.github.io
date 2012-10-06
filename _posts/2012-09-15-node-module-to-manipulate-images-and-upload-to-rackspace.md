---
layout: post
categories: [cloudfiles, imager, images, nodejs, rackspace, s3, amazon]
tumblr_id: 31620857044
date: 2012-09-15 23:58:00 UTC
title: Imager - node module to manipulate images, maintain different presets and upload them to rackspace cloudfiles and S3
---

A Node.js module to resize, crop, manipulate images, maintain different presets of the same image and upload to rackspace cloudfiles. Its completely asynchronous. 

## Installation
<pre class="prettyprint lang-bash"><code>$ npm install imager</code></pre>

## Usage
**You need to create imager configuration file with image variants and your storages**

Below is an example config

<pre class="prettyprint lang-js"><code>module.exports = {
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
}</code></pre>

and then

<pre class="prettyprint lang-js"><code>var Imager = require('imager');
  , imagerConfig = require('path/to/imager-config.js')
  , imager = new Imager(imagerConfig, 'Rackspace')</code></pre>

### Uploading file(s)

The callback recieves an err object, a files array (containing the names of the files which were
uploaded) and the cdnUri.

Suppose you have a variant, say `thumb`, then you can access the image by `cdnUri+'/'+'thumb_'+files[0]`. This would be the complete url of the image

1. **Form upload (multiple images)**

  If you are using express, you will recieve all the form files in `req.files`.

    <pre class="prettyprint lang-js"><code>imager.upload(req.files.image, function(err, cdnUri, files) {
      // do your stuff
  }, 'projects')</code></pre>

  Here, `projects` is your scope or variant. If you don't specify the scope or the variant, imager
  will try to look for a default variant named `default`. You must either specify a variant like
  above or provide a `default` variant.

2. **Upload local images**

    <pre class="prettyprint lang-js"><code>imager.upload(['/path/to/file'], function (err, cdnUri, files) {
    // do your stuff
  }, 'projects')</code></pre>

  Here files can be an array or a string. Make sure the path is
  absolute.

### Removing file(s)

1. **Remove from cloudfiles**

    <pre class="prettyprint lang-js"><code>var files = ['1330838831049.png', '1330838831049.png']
  imager.remove(files, function (err) {
      // do your stuff
  }, 'projects')</code></pre>

  `files` can be array of filenames or a string of single filename.

  Even here, if the variant is not specified, imager will try to look for the `default` variant. If neither
  of them are provided, you will get an error.

## Debugging
If you specify `debug: true` in the imager config, you can see the logs of uploaded / removed files.

## To-do's
* Support amazon storage
* Write more tests

**Resources:**

* [Github source](https://github.com/madhums/node-imager)