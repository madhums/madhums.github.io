---
layout: post
categories: [imager, nodejs, amazon, s3]
tumblr_id: 32283474082
date: 2012-09-25 21:32:57 UTC
title: node-imager now supports amazon S3
---

In my [previous post](http://madhums.tumblr.com/post/31620857044/node-module-to-manipulate-images-and-upload-to-rackspace) I described how to use node-imager to upload images (with different presets) to rackspace cloudfiles. Today I have added support for amazon S3. 

To use S3 as your storage, add the below in the imager config

```js
storage: {
  S3: {
    key: 'API_KEY',
    secret: 'SECRET',
    bucket: 'BUCKET_NAME'
  }
}
```

and specify `S3` while initializing imager

```js
var imager = new Imager(imagerConfig, 'S3')
```

**Resources**:

* [node-imager on github](https://github.com/madhums/node-imager)
