#!/bin/bash

# Base directory for the Jekyll site
BASE_DIR="$(pwd)"

# Function to fix the navigation bar to include categories from posts
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

# Function to fix the footer to include pages as footer navigation
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

# Run all fixes
fix_navbar
fix_footer

echo "Navigation and footer have been updated successfully."
