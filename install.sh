CHECK=$(ls | grep "findAndReplace")

if [ -z "$CHECK" ]; then
    echo "findAndReplace not found"
    git clone https://github.com/elliot40404/fr.git
    cd fr
    sudo ln -s $(pwd)/findAndReplace.sh /usr/local/bin/fr
else
    echo "findAndReplace found"
    echo "Adding to PATH"
    sudo ln -s $(pwd)/findAndReplace.sh /usr/local/bin/fr
fi
