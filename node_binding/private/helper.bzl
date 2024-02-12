def _int_flag_impl(ctx):
    allowed_values = ctx.attr.values
    value = ctx.build_setting_value
    if len(allowed_values) != 0 and value not in ctx.attr.values:
        fail(
            "Error setting %s: invalid value '%d'. Allowed values are %s" % (
                ctx.label,
                value,
                ",".join([str(val) for val in allowed_values]),
            ),
        )

int_flag = rule(
    implementation = _int_flag_impl,
    build_setting = config.int(flag = True),
    attrs = {
        "values": attr.int_list(
            doc = "The list of allowed values for this setting. An error is raised if any other value is given.",
        ),
    },
    doc = "An int-typed build setting that can be set on the command line",
)
