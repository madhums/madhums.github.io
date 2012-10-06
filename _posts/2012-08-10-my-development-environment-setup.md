---
layout: post
categories: [dotfiles, development]
tumblr_id: 29122941812
date: 2012-08-10 13:43:00 UTC
title: my development environment setup!
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
  * `e