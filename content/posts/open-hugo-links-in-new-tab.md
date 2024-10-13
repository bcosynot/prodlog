+++
title = "Open Hugo Links in New Tab"
date = "2024-10-13T17:43:02-04:00"
author = "Vivek Ranjan"
authorTwitter = "bcosynot" #do not include @
cover = ""
tags = ["hugo", "customization"]
keywords = ["hugo", "links"]
description = "Customize Hugo to open external links in a new tab."
showFullContent = false
readingTime = true
hideComments = false
+++

Hugo will default to opening all links in the current tab. I wanted to modify it so that links to _other_ websites open
in a new tab, but links to other pages on my blog open on the current tab.

Hugo has [some documentation](https://gohugo.io/render-hooks/links/) (this will open in a new tab :)) that served as a
starting point.

Put this snippet in your blog's `layout/_default/_markup/render-link.html` file

```html
{{- $u := urls.Parse .Destination -}}
<a href="{{ .Destination | safeURL }}"
   {{- with .Title }} title="{{ . }}"{{ end -}}
   {{- if $u.IsAbs }} rel="external" target="_blank"{{ end -}}
>
    {{- with .Text }}{{ . }}{{ end -}}
</a>
{{- /* chomp trailing newline */ -}}
```

The `target="_blank"` is the piece that causes the link to open in a new tab.
