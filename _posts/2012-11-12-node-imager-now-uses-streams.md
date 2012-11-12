---
layout: post
categories: [javascript, nodejs, streams, imager]
date: 2012-11-12 22:51:59 UTC
title: node-imager now uses streams
keywords: javascript, nodejs, streams, imager
summary: node-imager now uses streams. Removed all the file IO for all the images that were processed by graphicsmagick
---

Two days ago, a new extension was created for graphicsmagick - [gm-buffer](https://github.com/skimcom/node-gm-buffer).

> A plugin for gm module, which enables simple buffering of image binary for later content-length detection

It gives the buffer of the processed file using which you can get the length of the file to be uploaded. The new version (0.1.5) of [node-imager](https://github.com/madhums/node-imager) also skips all the file IO and simply uses streams for uploading.

If you are using node-imager, you should upgrade to 0.1.5 and take advantage of the awesomeness of node streaming!

**Note**: Though it uses streaming, the whole buffered object is kept in memory, which is not the optimal way of doing things with streaming. But because of S3's [limitations](http://stackoverflow.com/questions/8653146/can-i-stream-a-file-upload-to-s3-without-a-content-length-header) of sending `content-length`, you will have to store the object in the memory.

---
### Resources:

* [node-imager](https://github.com/madhums/node-imager)
* [node-gm-buffer](https://github.com/skimcom/node-gm-buffer)
