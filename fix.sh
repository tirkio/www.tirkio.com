#!/bin/bash

# Create necessary directories
mkdir -p _layouts _includes _posts pages assets

# Create _config.yml
cat <<EOL > _config.yml
title: TiRKiO
description: Your description here
url: "https://yourdomain.com"
baseurl: ""
paginate: 5

plugins:
  - jekyll-paginate
  - jekyll-sitemap
  - jekyll-feed
  - jekyll-seo-tag
  - jekyll-archives

defaults:
  - scope:
      path: ""
      type: "posts"
    values:
      layout: "post"

collections:
  pages:
    output: true

paginate_path: "/page:num/"
EOL

# Create Gemfile
cat <<EOL > Gemfile
source 'https://rubygems.org'

gem 'jekyll', '~> 4.3.0'
gem 'jekyll-paginate'
gem 'jekyll-sitemap'
gem 'jekyll-feed'
gem 'jekyll-seo-tag'
gem 'jekyll-archives'
EOL

# Create index.html
cat <<EOL > index.html
---
layout: default
---

<h1>Welcome to TiRKiO</h1>
<p>Latest Posts:</p>
<ul>
  {% for post in paginator.posts %}
    <li><a href="{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>
EOL

# Create _layouts/default.html
cat <<EOL > _layouts/default.html
<!DOCTYPE html>
<html lang="en">
<head>
  {% seo %}
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@2/css/pico.min.css" />
</head>
<body>
  {% include header.html %}
  <main class="container">
    {{ content }}
  </main>
  {% include footer.html %}
</body>
</html>
EOL

# Create _layouts/post.html
cat <<EOL > _layouts/post.html
---
layout: default
---

<article>
  <h1>{{ page.title }}</h1>
  <p>{{ page.date | date: "%B %d, %Y" }}</p>
  {{ content }}
</article>

<aside>
  {% include toc.html %}
</aside>

<div id="disqus_thread"></div>
<script>
  var disqus_config = function () {
    this.page.url = "{{ page.url | absolute_url }}";
    this.page.identifier = "{{ page.id }}";
  };
</script>
<script src="https://<your-disqus-shortname>.disqus.com/embed.js" data-timestamp="{{ "now" | date: "%s" }}"></script>
EOL

# Create _layouts/page.html
cat <<EOL > _layouts/page.html
---
layout: default
---

<section>
  <h1>{{ page.title }}</h1>
  {{ content }}
</section>

<aside>
  {% include toc.html %}
</aside>
EOL

# Create _includes/header.html
cat <<EOL > _includes/header.html
<header>
  <h1><a href="{{ site.baseurl }}">{{ site.title }}</a></h1>
  <nav>
    <ul>
      {% for category in site.categories %}
        <li><a href="/categories/{{ category[0] }}">{{ category[0] }}</a></li>
      {% endfor %}
    </ul>
  </nav>
</header>
EOL

# Create _includes/footer.html
cat <<EOL > _includes/footer.html
<footer>
  <nav>
    <ul>
      {% for page in site.pages %}
        <li><a href="{{ page.url }}">{{ page.title }}</a></li>
      {% endfor %}
    </ul>
  </nav>
  <p>&copy; {{ site.time | date: '%Y' }} {{ site.title }}</p>
</footer>
EOL

# Create _includes/toc.html
cat <<EOL > _includes/toc.html
<nav>
  <h3>Table of Contents</h3>
  <ul>
    {% for header in page.content | split: "<h2>" %}
      {% if forloop.index > 1 %}
        <li><a href="#{{ header | slugify }}">{{ header | strip_html }}</a></li>
      {% endif %}
    {% endfor %}
  </ul>
</nav>
EOL

# Create _posts/2024-12-21-welcome-to-jekyll.md
cat <<EOL > _posts/2024-12-21-welcome-to-jekyll.md
---
title: Welcome to Jekyll
categories: [intro]
---

This is your first post on your new Jekyll site.
EOL

# Create pages/about.md
cat <<EOL > pages/about.md
---
layout: page
title: About
---

This is the About page.
EOL

# Create pages/contact.md
cat <<EOL > pages/contact.md
---
layout: page
title: Contact
---

This is the Contact page.
EOL

echo "All files have been created successfully!"
