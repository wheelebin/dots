action=${1}
vm_name=${2:-dots}
vm_user=${3:-someuser}

if [[ -z $action ]]; then
    echo "[ENV-TOOLS] No action entered"
    exit;
fi

echo "[ENV-TOOLS] Running: $action (vm_name: $vm_name, vm_user: $vm_user)"

if [[ $action == "dev" ]]; then
    orbctl delete ${vm_name}
    orbctl create -u ${vm_user} -p -a arm64 ubuntu ${vm_name}
    
    cmd="sudo apt install -y git && git clone git@github.com:wheelebin/env.git && /bin/bash ./env/main.sh; bash -l"
    ssh ${vm_user}@${vm_name}@orb -t "$cmd"
elif [[ $action == "ssh" ]]; then
    ssh "${vm_user}@${vm_name}@orb"
elif [[ $action == "rm" ]]; then
    orbctl delete ${vm_name}
elif [[ $action == "push" ]]; then
    git add -A
    git commit -m "random deb push"
    git push
fi
