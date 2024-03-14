---
layout: page
title: Blog
permalink: /blog/
---

<div class="blog">

  <ul class="post-list">
    {% for post in site.posts %}
      <li>
        {% assign date_format = site.minima.date_format | default: "%b %d, %Y" %}
        <span class="post-meta text-align-right">{{ post.date | date: date_format }}</span>

        <a class="post-link" href="{{ post.url | relative_url }}">{{ post.title | escape }}</a>

      </li>
    {% endfor %}
  </ul>

</div>
