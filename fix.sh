#!/bin/bash

# Set the site name and repository
SITE_NAME="TiRKiO"
REPO_URL="https://github.com/tirkio/tirkio.github.io"

# Set the theme name
THEME_NAME="./"

# Create the theme folder structure
echo "Creating Jekyll theme: $THEME_NAME"
mkdir -p $THEME_NAME/{_layouts,_includes,_sass,assets/css,assets/js}

cd $THEME_NAME || exit

# Create the required files
echo "Creating theme files..."

# Default Layout
cat <<EOL > _layouts/default.html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta name="theme-color" content="#2a3140" />
  <meta name="description" content="{{ site.description }}" />
  <title>{{ page.title | default: site.title }}</title>
  <link rel="stylesheet" href="{{ '/assets/css/style.css' | relative_url }}" />
  <link rel="icon" href="{{ '/favicon.png' | relative_url }}" />
</head>
<body>
  <a href="#content" class="skip-to-content">Skip to content</a>
  {% include header.html %}
  <main id="content" class="container">
    {{ content }}
  </main>
  {% include footer.html %}
</body>
</html>
EOL

# Post Layout
cat <<EOL > _layouts/post.html
{% include side-menu.html %}
<div class="content">
  <article>
    <h1>{{ page.title }}</h1>
    {{ content }}
  </article>
</div>
EOL

# Header Include
cat <<EOL > _includes/header.html
<header>
  <div class="container">
    <a href="{{ site.baseurl }}/" class="logo" aria-label="{{ site.title }} homepage">
      {{ site.title }}
    </a>
    <nav>
      <ul>
        {% for category in site.categories %}
        <li><a href="{{ category[0] | relative_url }}">{{ category[0] }}</a></li>
        {% endfor %}
      </ul>
    </nav>
    <ul class="icons">
      <li>
        <a href="https://github.com/tirkio" target="_blank" aria-label="GitHub">
          GitHub
        </a>
      </li>
    </ul>
  </div>
</header>
EOL

# Footer Include
cat <<EOL > _includes/footer.html
<footer>
  <div class="container">
    <section>
      <nav class="links">
        <ul>
          {% for page in site.pages %}
          {% unless page.title == nil %}
          <li><a href="{{ page.url | relative_url }}">{{ page.title }}</a></li>
          {% endunless %}
          {% endfor %}
        </ul>
      </nav>
      <p>Built with <a href="https://picocss.com" target="_blank">PicoCSS</a> and Jekyll.</p>
    </section>
  </div>
</footer>
EOL

# Side Menu Include
cat <<EOL > _includes/side-menu.html
<aside>
  <ul>
    {% for heading in page.content | markdownify | split: '<h' %}
    {% if heading contains '>' %}
      <li><a href="#{{ heading | split: '>' | first | remove: '/' }}">{{ heading | split: '>' | last | remove: '</h' }}</a></li>
    {% endif %}
    {% endfor %}
  </ul>
</aside>
EOL

# SCSS: Style
cat <<EOL > _sass/style.scss
@import "https://unpkg.com/@picocss/pico@latest/css/pico.min.css";

/* Additional styles */
.skip-to-content {
  position: absolute;
  top: -40px;
  left: 0;
  background: #000;
  color: #fff;
  padding: 8px;
  z-index: 1000;
}
.skip-to-content:focus {
  top: 0;
}
EOL

# CSS Entry Point
cat <<EOL > assets/css/style.css
---
---
@import "../_sass/style.scss";
EOL

# Config File
cat <<EOL > _config.yml
title: "TiRKiO"
description: "A minimal Jekyll theme styled with PicoCSS."
baseurl: "" # Leave empty for GitHub Pages root
url: "https://www.tirkio.com"
theme: jekyll-theme-picocss
github_username: "tirkio"
EOL


# Finalizing
echo "Jekyll theme '$THEME_NAME' created successfully."
echo "You can now upload this theme to GitHub Pages:"
echo "1. Create a new GitHub repository."
echo "2. Push the contents of '$THEME_NAME' folder to the repository."
echo "3. Enable GitHub Pages in the repository settings."
