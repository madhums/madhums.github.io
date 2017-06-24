---
layout: post
title: Install/update node.js in just one command!
date: 2012-09-26 23:50:00 UTC
description: Install or update node.js in one command
keywords: install, nodejs, update
categories: [node.js, bash]
---

A simple script to install/update the much frequently updated [node.js](http://nodejs.org) platform.

Here's what you have to do to install/update node.js and npm to the version you want in just 1 command

```sh
$ curl https://raw.github.com/gist/3791075 | sh -s 0.8.10
```

Its a bit difficult to remember the url everytime you want to update, so you can create a simple alias function which does the job. Here's how

Put the below in your `~/.bash_profile`

```sh
function update-node {
  version=$1
  curl https://raw.github.com/gist/3791075 | sh -s $version
}
```

Now you can simply run `update-node 0.8.10` !

Oh and btw, it will install node to `~/local/node` directory.

---

## Resources:

* [gist source](https://gist.github.com/3791075)
