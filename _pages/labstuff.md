---
layout: archive
title: "Lab resources"
permalink: /labstuff/
author_profile: true
---

{% include base_path %}


{% for post in site.labstuff %}
  {% include archive-single.html %}
{% endfor %}

## Code


{% for post in site.code %}
  {% include archive-single.html %}
{% endfor %}



