# Bazel Rules for [Node.js Native Addons](https://nodejs.org/api/addons.html)

## Overview

This repository contains rules for building
[Node.js Native Addons](https://nodejs.org/api/addons.html) with
[Bazel](https://bazel.build) build system.

* [`node_extension`](node_binding/build_defs.bzl)

  This is a wrapper around `cc_binary` rule that builds a Node.js Native Addon
  with [Node-API headers](https://github.com/nodejs/node-api-headers),
  [node-addon-api](https://github.com/nodejs/node-addon-api) headers, and
  appropriate build flags, producing a `.node` file.

* [`node_binding_cc_library`](node_binding/build_defs.bzl)

  This is a wrapper around `cc_library` rule that builds a C/C++ library with
  [Node-API headers](https://github.com/nodejs/node-api-headers),
  [node-addon-api](https://github.com/nodejs/node-addon-api) headers, and
  appropriate build flags. This can be used as a dependency of `node_extension`
  rule.

See [examples](examples) for more details.


## Installation

### If your project adopts [Bzlmod](https://bazel.build/external/migration) system

Add the following to your `MODULE.bazel` file:

```Starlark
bazel_dep(name = "rules_node_binding")
archive_override(
    module_name = "rules_node_binding",
    integrity = "sha256-yrGTzp9iRs9ZnXdsW3mogn5VAlJRCcREBjeOmhsfoVM=",
    strip_prefix = "rules_node_binding-4bd65b67ef73eb5776a0909953323adcfff2ce3d",
    urls = ["https://github.com/kon72/rules_node_binding/archive/4bd65b67ef73eb5776a0909953323adcfff2ce3d.tar.gz"],
)
```

### If your project is using WORKSPACE system

Add the following to your `WORKSPACE` file:

```Starlark
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "rules_node_binding",
    integrity = "sha256-yrGTzp9iRs9ZnXdsW3mogn5VAlJRCcREBjeOmhsfoVM=",
    strip_prefix = "rules_node_binding-4bd65b67ef73eb5776a0909953323adcfff2ce3d",
    urls = ["https://github.com/kon72/rules_node_binding/archive/4bd65b67ef73eb5776a0909953323adcfff2ce3d.tar.gz"],
)

load("@rules_node_binding//node_binding:repositories.bzl", "rules_node_binding_setup")

rules_node_binding_setup()
```


## FAQ

### How do I change Node-API version to build an addon against?

You can set it by the command line flag:

```shell
bazel build //my/node/extension:target --@rules_node_binding//node_binding:napi_version=3
```

### Can I use Node.js/V8/libuv API which is not part of Node-API?

Currently, no. Feel free to open an issue if you need it.
