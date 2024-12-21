#!/bin/bash

# Function to backup a file before modification
backup_file() {
  local file=$1
  if [ -f "$file" ]; then
    cp "$file" "$file.bak"
    echo "Backup created for $file"
  fi
}

# Restore missing sidebar.html include
includes_dir="_includes"
if [ ! -d "$includes_dir" ]; then
  mkdir -p "$includes_dir"
  echo "Created _includes directory."
fi

sidebar_file="$includes_dir/sidebar.html"
if [ ! -f "$sidebar_file" ]; then
  cat <<EOL > "$sidebar_file"
<div class="sidebar sticky-top">
    <div class="sidebar-section">
        <h5><span>Your Ad Here</span></h5>
        <img src="{{ site.baseurl }}/assets/images/ad.png" alt="Advertisement">
    </div>
</div>
EOL
  echo "Restored missing $sidebar_file."
else
  echo "$sidebar_file already exists. No changes made."
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

# Re-include Disqus in `_layouts/post.html`
default_post_layout="_layouts/post.html"
backup_file "$default_post_layout"
sed -i '' "/<!-- Begin Comments/,/<!--End Comments/d" "$default_post_layout"
sed -i '' "/<div class='article-post serif-font'>/a \
            <!-- Begin Comments\
            ================================================== -->\
            <section>\
            <div id="comments">\
                {% include disqus.html %} \n            </div>\
            </section>\
            <!--End Comments\
            ================================================== -->" "$default_post_layout"

echo "Disqus integration re-included in $default_post_layout."

# Reset `_config.yml` to default settings
config_file="_config.yml"
backup_file "$config_file"
cat <<EOL > $config_file
title: "My Blog"
email: your-email@example.com
timezone: UTC
baseurl: ""
permalink: "/:title/"

disqus: "your-disqus-shortname"

plugins:
  - jekyll-feed
  - jekyll-sitemap
  - jekyll-seo-tag

paginate: 10
EOL
echo "_config.yml reset to default with Disqus configuration."

# Clean custom layouts
for layout in about contact categories privacy-policy; do
  if [ -f "pages/$layout.html" ] || [ -f "pages/$layout.md" ]; then
    echo "Removing custom page: $layout..."
    rm "pages/$layout.html" "pages/$layout.md"
  fi

done

echo "Customizations removed, sidebar restored, and Disqus re-included. Run 'jekyll serve' to test your site."
