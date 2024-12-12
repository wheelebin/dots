#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# https://stackoverflow.com/questions/12815774/importing-functions-from-a-shell-script
#echo $script_dir;
#exit

grep=""
dry_run="0"

setup_dir=`find $script_dir/setup -mindepth 1 -maxdepth 1 -executable`

for s in $setup_dir; do
    echo "[ENV-TOOLS] running setup script: $s"
    $s
done


echo "DONE!"
tail -f /dev/null
