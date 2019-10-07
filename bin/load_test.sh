#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

apply_load() {
  local url="$1"
  for i in {1..10000}
  do
    curl --silent "${url}"
  done
}
main() {
  local url="$1"

  apply_load ${url} &
  apply_load ${url} &
}

main "$@"
