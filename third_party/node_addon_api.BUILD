licenses(["notice"])  # MIT license

exports_files(["COPYING"])

cc_library(
    name = "node_addon_api",
    srcs = ["napi-inl.h"],
    hdrs = ["napi.h"],
    includes = ["."],
    visibility = ["//visibility:public"],
    deps = ["@node_api_headers"],
)
