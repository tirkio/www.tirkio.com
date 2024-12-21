#!/bin/bash

# Base directory for the Jekyll site
BASE_DIR="$(pwd)"

# Function to fix the navigation bar
fix_navbar() {
  cat <<EOL > "$BASE_DIR/_includes/navbar.html"
<div class="navigation-wrap start-header start-style">
    <nav class="navbar navbar-expand-lg">
        <div class="container">

          <a class="navbar-brand text-dark font-weight-bold big d-flex align-items-center" href="{{site.baseurl}}/">
              <span class="d-none d-md-inline-block">{{ site.title }}</span>
          </a>
    
          <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
            <svg xmlns="http://www.w3.org/2000/svg" width="26" height="26" fill="currentColor" class="bi bi-three-dots-vertical" viewBox="0 0 16 16">
              <path d="M9.5 13a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"/>
            </svg>
          </button>

          <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ml-auto font-weight-bold d-flex align-items-center">
              {% assign categories = site.categories | sort %}
              {% for category in categories %}
                <li class="nav-item">
                  <a class="nav-link px-3" href="{{ site.baseurl }}/categories/{{ category[0] | slugify }}">
                    {{ category[0] }}
                  </a>
                </li>
              {% endfor %}
            </ul>
          </div>

        </div>
      </nav>
</div>
EOL
}

# Function to fix the footer
fix_footer() {
  cat <<EOL > "$BASE_DIR/_includes/footer.html"
<footer class="bg-white border-top p-3 text-muted small">
    <div class="container">
        <div class="row align-items-center justify-content-between">
            <div>
                {% assign all_pages = site.pages | sort: 'title' %}
                {% for page in all_pages %}
                  {% if page.title %}
                    <span><a href="{{ site.baseurl }}{{ page.url }}">{{ page.title }}</a></span>
                    {% if forloop.last == false %}&middot;{% endif %}
                  {% endif %}
                {% endfor %}
            </div>
            <div>
                <span>Copyright © <script>document.write(new Date().getFullYear())</script></span>
            </div>
        </div>
    </div>
</footer>
EOL
}

# Function to fix categories layout
fix_categories_layout() {
  cat <<EOL > "$BASE_DIR/_layouts/categories.html"
---
title: "Categories"
layout: default
permalink: "/categories.html"
---
{% for category in site.categories %}
<h4 class="mt-5 mb-4 pb-2 border-bottom" id="{{ category[0] | slugify }}">
  <span class="text-capitalize small font-weight-bold">{{ category[0] }}</span>
</h4>
<div class="row">
  {% assign posts_in_category = category[1] %}
  {% for post in posts_in_category %}
    <div class="col-md-4 mb-5">
      <a href="{{ post.url | absolute_url }}">{{ post.title }}</a>
    </div>
  {% endfor %}
</div>
{% endfor %}
EOL
}

# Function to fix postbox image logic
fix_postbox_image() {
  sed -i '' 's/<span class="rounded mb-4" src/<img class="rounded mb-4" src/' "$BASE_DIR/_includes/postbox.html"
}

# Function to fix pagination logic
fix_pagination() {
  cat <<EOL > "$BASE_DIR/_includes/pagination.html"
<nav class="pagination" role="pagination">
    {% if paginator.previous_page %}
        <a class="newer-posts" href="{{ paginator.previous_page_path | prepend: site.baseurl }}">&laquo; Newer</a>
    {% endif %}
    <span class="page-number d-none">Page {{paginator.page}} of {{paginator.total_pages}}</span>
    {% if paginator.next_page %}
        <a class="older-posts" href="{{ paginator.next_page_path | prepend: site.baseurl }}">Older &raquo;</a>
    {% endif %}
</nav>
EOL
}

# Run all fixes
fix_navbar
fix_footer
fix_categories_layout
fix_postbox_image
fix_pagination

echo "All corrections have been applied successfully."
