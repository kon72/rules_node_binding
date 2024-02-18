load("//node_binding/private:napi_versions.bzl", "NAPI_VERSIONS")

# Sanitize a dependency so that it works correctly from external repositories.
def _clean_dep(dep):
    return str(Label(dep))

NODE_BINDING_CC_LIBRARY_COPTS = [
    # Used in node-api-headers
    "-DBUILDING_NODE_EXTENSION",
    # Used in node-addon-api
    "-DNAPI_DISABLE_CPP_EXCEPTIONS",
    "-DNODE_ADDON_API_DISABLE_DEPRECATED",
    "-DNODE_ADDON_API_ENABLE_MAYBE",
] + select({
    _clean_dep(":napi_version_%s_enabled" % version): ["-DNAPI_VERSION=%s" % version]
    for version in NAPI_VERSIONS
}) + select({
    _clean_dep(":macos"): [
        "-D_DARWIN_USE_64_BIT_INODE=1",
    ],
    "//conditions:default": [],
}) + select({
    _clean_dep(":msvc_compiler"): [],
    "//conditions:default": [
        "-D_LARGEFILE_SOURCE",
        "-D_FILE_OFFSET_BITS=64",
    ],
})

NODE_BINDING_CC_LIBRARY_DEPS = [
    _clean_dep("@node_addon_api"),
]

def node_extension(
        name,
        copts = [],
        linkopts = [],
        deps = [],
        visibility = None,
        testonly = None,
        **kwargs):
    native.cc_binary(
        name = "%s_cc_binary" % name,
        testonly = testonly,
        copts = copts + NODE_BINDING_CC_LIBRARY_COPTS + select({
            _clean_dep(":msvc_compiler"): [],
            "//conditions:default": [
                "-fvisibility=hidden",
                "-fvisibility-inlines-hidden",
            ],
        }),
        linkopts = linkopts + select({
            _clean_dep(":macos"): [
                "-undefined",
                "dynamic_lookup",
            ],
            "//conditions:default": [],
        }),
        linkshared = True,
        visibility = ["//visibility:private"],
        deps = deps + NODE_BINDING_CC_LIBRARY_DEPS + select({
            _clean_dep(":msvc_compiler"): [
                _clean_dep("//node_binding/private:win_delay_load_hook"),
                _clean_dep("//node_binding/private:node_api.lib"),
            ],
            "//conditions:default": [],
        }),
        **kwargs
    )

    native.genrule(
        name = name,
        testonly = testonly,
        srcs = ["%s_cc_binary" % name],
        outs = ["%s.node" % name],
        cmd = "cp $< $@",
        visibility = visibility,
    )

def node_binding_cc_library(
        name,
        copts = [],
        deps = [],
        **kwargs):
    native.cc_library(
        name = name,
        copts = copts + NODE_BINDING_CC_LIBRARY_COPTS,
        deps = deps + NODE_BINDING_CC_LIBRARY_DEPS,
        **kwargs
    )
