#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
patches_dir=`find $script_dir/patches -mindepth 1 -maxdepth 1 -executable`
actionArg=${1}
actionOptsArg=${2}

if [[ $actionArg == "setup" ]]; then
    for s in $patches_dir; do
        echo "running patch: $s"
        $s
    done
elif [[ $actionArg == "apply" ]]; then
    if [[ ! -f "${patches_dir}/${actionOptsArg}" ]]; then
        echo "patch not found: $actionOptsArg"
        exit
    fi

    echo "running patch: $s"
    $s
else
    echo "Unkown action ${actionArg}"
fi

echo "Done!"
