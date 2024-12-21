#!/bin/bash

# Function to backup a file before modification
backup_file() {
  local file=$1
  if [ -f "$file" ]; then
    cp "$file" "$file.bak"
    echo "Backup created for $file"
  fi
}

# Remove custom includes
if [ -d "_includes" ]; then
  echo "Removing custom includes..."
  rm -rf _includes
fi

# Restore navigation in `_layouts/default.html`
layout_file="_layouts/default.html"
backup_file "$layout_file"
sed -i '' '/<ul class="navbar-nav/,/<\/ul>/d' "$layout_file"
sed -i '' "/<div class='collapse navbar-collapse'/a \
<ul class='navbar-nav'>\
  <li class='nav-item'><a class='nav-link' href='{{ site.baseurl }}/'>Home</a></li>\
  <li class='nav-item'><a class='nav-link' href='{{ site.baseurl }}/about'>About</a></li>\
  <li class='nav-item'><a class='nav-link' href='{{ site.baseurl }}/contact'>Contact</a></li>\
</ul>" "$layout_file"

echo "Navigation reset to default in $layout_file."

# Remove unnecessary Disqus integration
includes_disqus="_includes/disqus.html"
if [ -f "$includes_disqus" ]; then
  echo "Removing Disqus integration..."
  rm "$includes_disqus"
fi

default_post_layout="_layouts/post.html"
backup_file "$default_post_layout"
sed -i '' '/{%-? include disqus.html -?%}/d' "$default_post_layout"
echo "Disqus references removed from $default_post_layout."

# Reset `_config.yml` to default settings
config_file="_config.yml"
backup_file "$config_file"
cat <<EOL > $config_file
title: "My Blog"
email: your-email@example.com
timezone: UTC
baseurl: ""
permalink: "/:title/"

plugins:
  - jekyll-feed
  - jekyll-sitemap
  - jekyll-seo-tag

disqus: "" # Removed
paginate: 10
EOL
echo "_config.yml reset to default."

# Clean custom layouts
for layout in about contact categories privacy-policy; do
  if [ -f "pages/$layout.html" ] || [ -f "pages/$layout.md" ]; then
    echo "Removing custom page: $layout..."
    rm "pages/$layout.html" "pages/$layout.md"
  fi

done

echo "Customizations removed. Run 'jekyll serve' to test your site."

