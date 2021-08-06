# gcloud_ninja
Ninja tools to speed up my day to day life with gcloud

unix/macOS only

## install

### Clone
```
mkdir .ninja_tools && cd .ninja_tools
git clone git@github.com:KausthubK/gcloud_ninja.git
nano ./gcloud_ninja/gci.sh
```

Change the first line to your instance name:

    export GCI_INSTANCE='instance-name'
## Modify ~/.zshrc
Open up ```~/.zshrc``` in any editor of your choice

Add this line: 
    
    source ~/.ninja_tools/gcloud_ninja/gci.sh

Or add this line if you want to defensively check for it first:
    
    filename=${HOME}/.ninja_tools/gcloud_ninja/gci.sh && if test -f $filename; then source $filename; else "nope - gcloud ninja doesn't exist"; fi

## usage

```gci-start``` - start an instance
```gci-connect``` - connect to an instance in a terminal
```gci-stop``` - stop an instance
```gci-get-ip``` - if you want to check what your current external IP is


## Libraries
### gci.sh
- start stop and connect to an instance for ssh
- will backup your previous ~/ssh/config to ~/.ssh/config.backup_UnixTimeSinceEpoch