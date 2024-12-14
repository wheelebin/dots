action=${1}
vm_name=${2:-dotsDev}
vm_user=${3:-someuser}

if [[ -z $action ]]; then
    echo "[ENV-TOOLS] No action entered"
    exit;
fi

echo "[ENV-TOOLS] Running: $action (vm_name: $vm_name, vm_user: $vm_user)"

function dev() {
    orbctl delete ${vm_name}
    orbctl create -u ${vm_user} -p -a arm64 debian ${vm_name}
    
    cmd='sudo apt install -y git &&
        cd $HOME &&
        echo ".cfg" >> .gitignore &&
        git clone --bare git@github.com:wheelebin/dots.git $HOME/.cfg &&
        git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout
        bash .env-tools/main.sh setup; bash -l'

    ssh ${vm_user}@${vm_name}@orb -t "$cmd"
}

function push() {
    git --git-dir=$HOME/.cfg/ --work-tree=$HOME add $HOME/.env-tools
    git --git-dir=$HOME/.cfg/ --work-tree=$HOME commit -m "env-tools update push"
    git --git-dir=$HOME/.cfg/ --work-tree=$HOME push
}

if [[ $action == "start" ]]; then
    dev
elif [[ $action == "push" ]]; then
    push
elif [[ $action == "dev" ]]; then
    push
    dev
elif [[ $action == "ssh" ]]; then
    ssh "${vm_user}@${vm_name}@orb"
elif [[ $action == "rm" ]]; then
    orbctl delete ${vm_name}
fi
