# Sanitize a dependency so that it works correctly from external repositories.
def _clean_dep(dep):
    return str(Label(dep))

NODE_CC_LIBRARY_COPTS = select({
    _clean_dep("//node_binding:msvc_compiler"): [],
    "//conditions:default": [
        "-fvisibility=hidden",
        "-fvisibility-inlines-hidden",
    ],
}) + select({
    _clean_dep("//node_binding:macos"): [
        "-D_DARWIN_USE_64_BIT_INODE=1",
    ],
    "//conditions:default": [],
}) + select({
    _clean_dep("//node_binding:msvc_compiler"): [],
    "//conditions:default": [
        "-D_LARGEFILE_SOURCE",
        "-D_FILE_OFFSET_BITS=64",
    ],
})

NODE_CC_LIBRARY_DEPS = [
    "@node_addon_api",
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
        copts = copts + NODE_CC_LIBRARY_COPTS,
        linkopts = linkopts + select({
            _clean_dep("//node_binding:macos"): [
                "-undefined",
                "dynamic_lookup",
            ],
            "//conditions:default": [],
        }),
        linkshared = True,
        visibility = ["//visibility:private"],
        deps = deps + NODE_CC_LIBRARY_DEPS + select({
            _clean_dep("//node_binding:msvc_compiler"): [
                "@node_interface_library//:interface",
                "@node_interface_library//:win_delay_load_hook",
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

def node_cc_library(
        name,
        copts = [],
        deps = [],
        **kwargs):
    native.cc_library(
        name = name,
        copts = copts + NODE_CC_LIBRARY_COPTS,
        deps = deps + NODE_CC_LIBRARY_DEPS,
        **kwargs
    )
