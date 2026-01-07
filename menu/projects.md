---
layout: page_nonblog
title: Projects
permalink: /projects/
---

<p class="projects-intro">Things I've built and am building.</p>

<div class="projects-list">
{% assign sorted_projects = site.projects | sort: 'order' %}
{% for project in sorted_projects %}
<div class="project-item">
  <h2><a href="{{ project.url }}">{{ project.title }}</a></h2>
  {% if project.excerpt %}
    <p class="project-excerpt">{{ project.excerpt }}</p>
  {% endif %}
  {% if project.link %}
    <a href="{{ project.link }}" class="project-link">View Project →</a>
  {% endif %}
</div>
{% endfor %}
</div>
