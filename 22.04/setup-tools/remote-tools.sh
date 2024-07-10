#!/bin/bash

set -e

# hosts=("adsv-staging" "das-dev")
hosts=("adsv-prod-1")

setup_remote() {
    local host="$1"
    local target="$2"
    local setup_name="$3"

    # brew install gnu-tar
    # gtar -czvf "$target.tar.gz" "./$target"

    scp "./$target.tar.gz" "$host:~/"
    ssh "$host" "tar -xzvf ~/$target.tar.gz && cd ~/$target && ./$setup_name"
}

for index in "${!hosts[@]}"; do
    host="${hosts[$index]}"
    echo "$index setup $host"
    setup_remote "$host" "fzf-v2" "setup-fzf"
    setup_remote "$host" "starship-v2" "setup-starship"
    echo ""
    echo ""
done
