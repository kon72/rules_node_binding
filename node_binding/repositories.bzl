load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def rules_node_binding_setup(module_ctx = None):
    if not module_ctx:
        http_archive(
            name = "node_api_headers",
            build_file = "@rules_node_binding//third_party:node_api_headers.BUILD",
            sha256 = "16b272ed56b31e0aebe3e9214a4038187a5f4386390ceb65fb7d628d648ba4e4",
            strip_prefix = "node-api-headers-f62bc5ce4e7fe0ea7bad6f53cf64fee3a570ee11",
            url = "https://github.com/nodejs/node-api-headers/archive/f62bc5ce4e7fe0ea7bad6f53cf64fee3a570ee11.tar.gz",
        )

        http_archive(
            name = "node_addon_api",
            build_file = "@rules_node_binding//third_party:node_addon_api.BUILD",
            sha256 = "c8d22016c6c5427c8897217f6b1b246f1e06c4d9f450390473a1d1ec403cd3ac",
            strip_prefix = "node-addon-api-7.1.0",
            url = "https://github.com/nodejs/node-addon-api/archive/refs/tags/v7.1.0.tar.gz",
        )

rules_node_binding_extension = module_extension(
    implementation = rules_node_binding_setup,
)
