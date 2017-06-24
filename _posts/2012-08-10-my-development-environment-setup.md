---
layout: post
title: Dev environment setup!
description: Just a small writeup on how I have configured my development environment.
keywords: bash, development, environment, dotfiles
categories: [dotfiles, development, bash]
---

I am a node.js developer and in my everyday development I mostly have node.js , mongodb servers running, bash is my default shell, I was using sublimetext as my default editor until textmate was opensourced yesterday!

dotfiles are great way to manage your development environment. After doing things repeatedly, over and over again, I came up with some scripts which eased my job. All you need to know is bash scripting.

This is how I have organized my dev box.

`~/local` - all custom built stuff (servers, db servers etc)
`~/code` - all the projects you work on
`~/bin` - custom bash scripts if you are using any

My dotfiles contain the following

* `.gitconfig` - which is the global git-config
* `.bashrc` - which sources some additional scripts
  * `completions` - some bash completions
  * `aliases` - some alias commands
  * `paths` - exports some custom paths (~/bin for example)
  * `prompt` - PS1 which shows git branch
  * `extras` - which has some custom functions defined
  * `paths` - has some custom paths that I have added to `$PATH`
  * `bookmarks` - is a simple tool to bookmark any folder. You can use
    it like `$ bookmark rails` and then `$ go rails`

I also use [z](http://github.com/rupa/z) which is a folder jumping tool. You should definitely try
this! If you are planning to install [my dotfiles](https://github.com/madhums/dotfiles) make sure you have the
above mentioned folders created. I use a mac and my favourite font is
Menlo 13pt. This is how it [looks](http://f.cl.ly/items/1p3F3P473H2C0l3M1e2I/Screen%20Shot%202012-10-08%20at%201.19.12%20AM.png)
