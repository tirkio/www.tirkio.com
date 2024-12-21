#!/bin/bash

# Base directory
BASE_DIR="www.tirkio.com"

# Create directories
mkdir -p "$BASE_DIR/_includes"
mkdir -p "$BASE_DIR/_layouts"
mkdir -p "$BASE_DIR/_posts"
mkdir -p "$BASE_DIR/pages"

# Create files with content
cat <<EOL > "$BASE_DIR/_includes/pagination.html"
<nav class="pagination" role="pagination">
    {% if paginator.previous_page %}
        {% if paginator.previous_page == 1 %}
            <a class="newer-posts" href="{{site.baseurl}}/" title="Previous Page">&laquo; Newer</a>
        {% else %}
            <a class="newer-posts" href="{{ paginator.previous_page_path | prepend: site.baseurl | replace: '//', '/' }}" title="Previous Page">&laquo; Newer </a>
      {% endif %}
    {% endif %}
    <span class="page-number d-none"> &nbsp; &nbsp; Page {{paginator.page}} of {{paginator.total_pages}} &nbsp; &nbsp; </span>
    {% if paginator.next_page %} 
        <a class="older-posts" href="{{ paginator.next_page_path | prepend: site.baseurl | replace: '//', '/' }}" title="Next Page">Older &raquo;</a>
    {% endif %} 
</nav>
EOL

cat <<EOL > "$BASE_DIR/_includes/disqus.html"
<section class="disqus">
    <div id="disqus_thread"></div>
    <script type="text/javascript">
        var disqus_shortname = '{{site.disqus}}'; 
        var disqus_developer = 0;
        (function() {
            var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
            dsq.src = window.location.protocol + '//' + disqus_shortname + '.disqus.com/embed.js';
            (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
        })();
    </script>
    <noscript>Please enable JavaScript to view the <a href="http://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
    <a href="http://disqus.com" class="dsq-brlink">comments powered by <span class="logo-disqus">Disqus</span></a>
</section>
EOL

cat <<EOL > "$BASE_DIR/_includes/sidebar.html"
<div class="sidebar sticky-top">
    <div class="sidebar-section">
        <h5><span>Your Ad Here</span></h5>
        <img src="{{site.baseurl}}/assets/images/ad.png">
    </div>
</div>
EOL

cat <<EOL > "$BASE_DIR/_includes/postbox.html"
<!-- begin post -->
{% assign author = site.authors[post.author] %}
<div class="card">
    <a href="{{ post.url | absolute_url }}">
        {% if post.image %} <span class="rounded mb-4" src="{{ site.baseurl }}/{{ post.image }}" alt="{{ post.title }}"> </span> {% endif %}
    </a>
    <div class="card-block">
        <h2 class="card-title h4 serif-font"><a href="{{ post.url | absolute_url }}">{{ post.title }}</a></h2>
        <p class="card-text text-muted">{{ post.excerpt | strip_html | truncatewords:15 }}</p>
        <div class="metafooter">
            <div class="wrapfooter small d-flex align-items-center">
                <span class="author-meta">
                By  <span class="post-name"> {% if post.author %}{{ author.display_name }}{% else %}{{ site.author }}{% endif %}, </span>             
                on <span class="post-date">{{ post.date | date_to_string }}</span>
                </span>               
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
</div>
<!-- end post -->
EOL

cat <<EOL > "$BASE_DIR/index.html"
---
title: Home
layout: default
background: '/img/bg-index.jpg'
---

<!-- Home Intro
================================================== -->
{% if page.url == "/" %} 
<div class="rounded mb-5 hero">
  <div class="row align-items-center justify-content-between">
    <div class="col-md-6">
      <h1 class="font-weight-bold mb-4 serif-font">Let me  teach you how to become successful online</h1>
      <p class="lead mb-4">My name is Lyam and I'm here to share with you my knowledge and experience of over 10 years of monetizing my blog.</p>
      <a href="{{site.baseurl}}/about" class="btn btn-dark text-white px-5 btn-lg">About me</a>
    </div>
    <div class="col-md-6 text-right pl-0 pl-lg-4">
      <img class="intro" height="500" src="{{site.baseurl}}/assets/images/intro.svg">      
    </div>
  </div>
</div>
{% endif %}

<!-- Featured
================================================== -->
<section class="row">
  {% for post in site.posts %}
      {% if post.featured == true %}
          <div class="col-md-4 mb-5">
          {% include postbox.html %}
          </div>
      {% endif %}
  {% endfor %}
  </div>
</section>

<!-- Posts List with Sidebar (except featured)
================================================== -->
<section class="row">
  <div class="col-sm-8">
    <div class="row">
      {% for post in paginator.posts %}
      {% unless post.featured == true %}
      <div class="col-md-6 mb-5">
        {% include postbox.html %}
      </div>
      {% endunless %}
      {% endfor %}
    </div>
    <!-- Pagination -->
    <div class="bottompagination">
      <span class="navigation" role="navigation">
          {% include pagination.html %}
      </span>
    </div>
  </div>
  <div class="col-sm-4">
    {% include sidebar.html %}
  </div>
</section>
EOL

# Add more files as necessary

# Notify user
echo "All files and directories have been created successfully."
