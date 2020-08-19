#!/bin/bash

# This file is licensed under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

# Walks commits in the submodule between the current state and the tip of the
# $BRANCH (default "main") on the remote and calls the specified command.

set -e
set -o pipefail

BRANCH="${BRANCH:-main}"
SUBMODULE_DIR="third_party/llvm-project"

pushd "${SUBMODULE_DIR?}"
START="$(git rev-parse HEAD)"
git checkout "${BRANCH?}"
git pull --ff-only origin "${BRANCH?}"
git checkout "${START?}"
readarray -t commits < <(git rev-list --ancestry-path HEAD^..${BRANCH?})
if [[ ${#commits[@]} == 0 ]]; then
  echo "Failed to find path between current HEAD and ${BRANCH?}"
  popd
  exit 1
fi
git status
popd

for commit in "${commits[@]?}"; do
  pushd "${SUBMODULE_DIR?}"
  git checkout "${commit?}"
  popd
  "$@";
done

git submodule update