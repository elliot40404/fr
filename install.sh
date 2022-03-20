#!/bin/bash

CHECK=$(ls | grep "findAndReplace")

if [ -z "$CHECK" ]; then
    echo "findAndReplace not found"
    if [[ -z $(which git) ]]; then
        echo "Cannot find git"
        echo "Please install git"
        echo "Exiting..."
    else
        cd ~
        git clone https://github.com/elliot40404/fr.git
        cd fr
        chmod +x findAndReplace.sh
        sudo ln -s $(pwd)/findAndReplace.sh /usr/local/bin/fr
        cd /usr/local/bin
        sudo chmod +x fr
    fi
else
    echo "findAndReplace found"
    echo "Adding to PATH"
    sudo ln -s $(pwd)/findAndReplace.sh /usr/local/bin/fr
    cd /usr/local/bin
    sudo chmod +x fr
fi
