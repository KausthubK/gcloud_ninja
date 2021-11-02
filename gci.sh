#!/bin/zsh
export GCI_INSTANCE='your-vm-instance-name'
export GCI_EXTERNAL_IP="*"
export GCI_USERNAME="username"

# 1. start (this will write ssh config)
# 2. connect (will connect to the current instance)
# 3. stop  (this will write ssh config)

function gci-get-ip(){
    gcloud compute instances list --filter="name=( 'NAME' ${GCI_INSTANCE} )" | awk '{print $5}' | tail -1
}

function gci-ssh-config-write-external-ip(){
    ## writes the following to ssh config so that anything 
    ## like VSCode that's searching for configured ssh hosts
    ## will autodetect it - so you can just connect without
    ## checking for gcloud IPs without making them static
    backup_time=$(date +%s)
    cp ~/.ssh/config ~/.ssh/config.backup_${backup_time}
    echo "HOST ${GCI_EXTERNAL_IP}" > ~/.ssh/config
    echo "    IdentityFile ~/.ssh/google_compute_engine" >> ~/.ssh/config
    echo "    User ${GCI_USERNAME}" >> ~/.ssh/config 
    echo "    AddKeysToAgent yes" >> ~/.ssh/config
    echo "    UseKeychain yes" >> ~/.ssh/config
    echo "    ForwardAgent yes" >> ~/.ssh/config
}

function gci-start(){
    gcloud compute instances start ${GCI_INSTANCE}
    OUT=$(gci-get-ip)
    export GCI_EXTERNAL_IP="${OUT}"
    gci-ssh-config-write-external-ip
}

function gci-connect(){
    gcloud beta compute ssh --ssh-flag="-A" "${GCI_INSTANCE}" -- -L 8888:localhost:8888
}

function gci-stop(){
    gcloud compute instances stop ${GCI_INSTANCE}
    export GCI_EXTERNAL_IP="*"
    gci-ssh-config-write-external-ip
}
