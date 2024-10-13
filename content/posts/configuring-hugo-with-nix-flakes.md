+++
title = "Configuring Hugo With Nix Flakes (like this blog)"
date = "2024-10-09T19:15:00-04:00"
author = "Vivek Ranjan"
tags = ["hugo", "nix", "flakes"]
categories = ["Nix", "Hugo", "Guides"]
showFullContent = false
readingTime = false
hideComments = false
slug = "hugo-nix"
+++

This blog is built with Hugo, running on a NixOS machine hosted by Hetzner.

This post gives a walkthrough of how I created a nix flake to easily build, run, and deploy this blog.
I will make the NixOS configuration for actually serving the website available in another blog.


### Features

1. Make hugo available to run the blog locally on my machine
2. Use hugo to generate the final static files to serve the blog

### Flake structure

Like any other flake, this one has inputs and outputs.

#### Inputs

I am pulling the theme I use for this blog (Terminal) as an input.

#### Outputs

There
