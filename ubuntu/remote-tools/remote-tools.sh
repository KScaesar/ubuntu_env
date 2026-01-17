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
    if [ ! -f "./$target.tar.gz" ]; then
        echo "Error: File ./$target.tar.gz does not exist."
        exit 1
    fi

    scp "./$target.tar.gz" "$host:~/"
    ssh "$host" "tar -xzvf ~/$target.tar.gz && cd ~/$target && ./$setup_name"
    ssh "$host" "test -f ~/$target.tar.gz && test -d ~/$target && rm -r ~/$target.tar.gz ~/$target"
}

for index in "${!hosts[@]}"; do
    host="${hosts[$index]}"
    echo "$index setup $host"
    setup_remote "$host" "fzf-v2" "setup-fzf"
    setup_remote "$host" "starship-v2" "setup-starship"
    echo ""
    echo ""
done


