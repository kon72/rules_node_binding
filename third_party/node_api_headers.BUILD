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
    defines = [
        "NAPI_VERSION=8",
        "BUILDING_NODE_EXTENSION",
    ],
    includes = ["include"],
    visibility = ["//visibility:public"],
)
