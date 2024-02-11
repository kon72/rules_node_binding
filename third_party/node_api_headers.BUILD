licenses(["notice"])  # MIT license

exports_files(["COPYING"])

cc_library(
    name = "node_api_headers",
    srcs = [
        "include/js_native_api.h",
        "include/js_native_api_types.h",
        "include/node_api_types.h",
    ],
    hdrs = ["include/node_api.h"],
    includes = ["include"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "node_api_def",
    srcs = ["def/node_api.def"],
    visibility = ["//visibility:public"],
)
