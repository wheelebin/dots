#!/bin/bash
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
setup_dir=`find $script_dir/setup -mindepth 1 -maxdepth 1 -executable`
source $script_dir/utils.sh 

for s in $setup_dir; do
    echo "running setup script: $s"
    $s
done

echo "setup done!"
