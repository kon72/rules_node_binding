licenses(["notice"])  # MIT license

exports_files(["COPYING"])

cc_library(
    name = "node_addon_api",
    srcs = ["napi-inl.h"],
    hdrs = ["napi.h"],
    defines = [
        "NAPI_DISABLE_CPP_EXCEPTIONS",
        "NODE_ADDON_API_DISABLE_DEPRECATED",
        "NODE_ADDON_API_ENABLE_MAYBE",
    ],
    visibility = ["//visibility:public"],
    deps = ["@node_api_headers"],
)
