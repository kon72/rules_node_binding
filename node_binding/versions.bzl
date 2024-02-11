PLATFORMS = {
    "aarch64-pc-windows-msvc": struct(
        compatible_with = [
            "@platforms//os:windows",
            "@platforms//cpu:aarch64",
        ],
        arch = "arm64",
    ),
    "x86_64-pc-windows-msvc": struct(
        compatible_with = [
            "@platforms//os:windows",
            "@platforms//cpu:x86_64",
        ],
        arch = "x64",
    ),
    "x86_32-pc-windows-msvc": struct(
        compatible_with = [
            "@platforms//os:windows",
            "@platforms//cpu:x86_32",
        ],
        arch = "x86",
    ),
}

def gen_node_config_settings(name = ""):
    for platform in PLATFORMS.keys():
        native.config_setting(
            name = "{name}{platform}".format(name = name, platform = platform),
            constraint_values = PLATFORMS[platform].compatible_with,
        )
