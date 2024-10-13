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
summary = "This guide demonstrates how I set up my Hugo blog using Nix Flakes, with a detailed explanation of the flake.nix file. You’ll learn how to manage dependencies, automate blog builds, and configure a development environment to quickly run and preview your site, all using Nix Flakes."
+++

This blog is built with Hugo, running on a NixOS machine hosted by Hetzner.

Working with Nix Flakes to develop, run, and deploy the blog turned out to be a fascinating experience. In this post,
I'll walk you through how I set everything up by explaining the `flake.nix` configuration I created. You can find the
current version of the file in use at [GitHub](https://github.com/bcosynot/prodlog/blob/main/flake.nix).

Using Nix I can run build and run this blog easily on different operating systems and CPU architectures. For example,
I develop this blog on an Intel macOS laptop and deploy it to a ARM server running NixOS.

This post does not cover the NixOS configuration for actually serving the website available. I will cover that in a
future post.

### Features

1. Make hugo available to run the blog locally on my machine
2. Use hugo to generate the final static files to serve the blog

### Flake structure

Like any other flake, this one has inputs and outputs.

#### Inputs

The inputs section defines the dependencies used to build the flake. These can be other flakes, but don't necessarily
need to be Flakes themselves.

```nix
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    utils.url = "github:numtide/flake-utils";
    hugo-terminal = {
      url = "github:panr/hugo-theme-terminal";
      flake = false;
    };
  };
```

In the above section, you can see that I am pulling the theme I use for this blog
([Terminal](https://github.com/panr/hugo-theme-terminal)) as an input. Note the `flake = false` attribute letting Nix
know that this is a non-flake repository.

The other inputs are
1. [`NixOS/nixpkgs`](https://github.com/NixOS/nixpkgs), which is a **huge** collection of software packages that can be
installed in Nix.
2. [`numtide/flake-util`](https://github.com/numtide/flake-utils), a collection of utility functions making writing nix
flakes easier.

#### Outputs

This section is where the majority of the logic lives and defines the end results and what should be produced.

##### Wrapper

```nix
 outputs = { self, nixpkgs, utils, hugo-terminal, ... }:
    utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
          };
        in
        {
```
This part begins the outputs block, where the following happens:

* `self, nixpkgs, utils, and hugo-terminal` are injected inputs, allowing access to the previously defined resources.
* `utils.lib.eachDefaultSystem` ensures that this configuration is compatible with all supported systems (Linux, macOS, etc. and their associated CPU architectures).
This enables you to use this flake on machines with different operating systems and CPU architectures.
* The `let` expression imports nixpkgs for the current system, providing access to the available packages for that system.

##### Packages

Packages are derivations (build outputs) that define the software and tools needed for the project.
In this flake, `hugo-blog` is a package that describes how to build the static site using Hugo and the specified theme.
Packages are more general-purpose and can be reused in different contexts.

```nix
packages.hugo-blog = pkgs.stdenv.mkDerivation rec {
            name = "hugo-blog";
            src = self;
            configurePhase = ''
              mkdir -p "themes/terminal"
              cp -r ${hugo-terminal}/* "themes/terminal"
            '';
            buildPhase = ''
              ${pkgs.hugo}/bin/hugo --minify
            '';
            installPhase = "cp -r public $out";
          };

packages.default = self.packages.${system}.hugo-blog;
```

This section defines a package called hugo-blog using `pkgs.stdenv.mkDerivation` function. This function builds the
package with a "standard environment" that provides a lot of common building tasks and lets you breakdown the package
into "phases".

Here’s what’s happening:

* name: The package is named hugo-blog.
* src: The source code for the package is the current Flake (self).
* configurePhase: In this phase, the theme from hugo-terminal is copied into the project’s theme folder.
* buildPhase: Hugo is run with the `--minify` flag, which generates the static site.
* installPhase: The generated files (from the public directory) are copied into the output directory (`$out`).
`$out` is a special variable referencing the package's output directory.

The last line sets the `hugo-blog` package, that we just created, as this system's default package.

##### Apps

Apps are executable programs or services that you can directly run. These are typically a higher-level abstraction than
packages, meant to be easily runnable.

```nix
          apps = rec {
            build = utils.lib.mkApp { drv = pkgs.hugo; };
            serve = utils.lib.mkApp {
              drv = pkgs.writeShellScriptBin "hugo-serve" ''
                ${pkgs.hugo}/bin/hugo server -D
              '';
            };
            default = serve;
          };

```

Here, we define two apps `build` and `serve` and set the latter as the default app. With this definition

* `nix run` and `nix run .#serve` will run the `hugo server -D` command, letting me preview the blog post quickly.
* While `nix run .#build` will run the `hugo` build process to generate static HTML pages, if I wanted to take a look at
the final version of built pages.


##### Development environment

The dev shell defines a shell environment for developers, pre-configured with the necessary tools and dependencies.
It’s particularly useful for onboarding new contributors or ensuring that the development environment remains consistent
across systems.

```nix
devShells.default =
            pkgs.mkShell {
              buildInputs = [ pkgs.hugo ];
              shellHook = ''
                mkdir -p themes
                ln -sn "${hugo-terminal}" "themes/terminal"
              '';
            };
        });
```

Here, the default develop environment includes the `hugo` package so I can use the CLI to generate new content or pages.
The `shellHook` attribute specifies what should occur when I run `nix develop`. It will create the themes directory and
create a symbolic link to the `hugo-terminal` directory that was pulled in as a dependency as described in the inputs
section.

