#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail

# Set by GH actions, see
# https://docs.github.com/en/actions/learn-github-actions/environment-variables#default-environment-variables
TAG=${GITHUB_REF_NAME}
# The prefix is chosen to match what GitHub generates for source archives
PREFIX="rules_node_binding-${TAG:1}"
ARCHIVE="rules_node_binding-$TAG.tar.gz"
git archive --format=tar --prefix="${PREFIX}/" "${TAG}" | gzip >"$ARCHIVE"
SHA=$(shasum -a 256 "$ARCHIVE" | awk '{print $1}')

cat <<EOF

## Installation

### If your project adopts [Bzlmod](https://bazel.build/external/migration) system

Add the following to your \`MODULE.bazel\` file:

\`\`\`starlark
bazel_dep(name = "rules_node_binding", version = "${TAG:1}")
\`\`\`

### If your project is using WORKSPACE system

Add the following to your \`WORKSPACE\` file:

\`\`\`starlark
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "rules_node_binding",
    sha256 = "${SHA}",
    strip_prefix = "${PREFIX}",
    url = "https://github.com/aspect-build/rules_js/releases/download/${TAG}/${ARCHIVE}",
)

load("@rules_node_binding//node_binding:repositories.bzl", "rules_node_binding_setup")

rules_node_binding_setup()
\`\`\`
EOF
