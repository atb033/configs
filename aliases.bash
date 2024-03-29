#!/bin/bash

toadi-copy-slam () {
    # Copies over the sdk-version of SLAM to remote toadi
    ROBOT_ALIAS=$1
    toadi=$ROBOT_ALIAS
    if [ -z $ROBOT_ALIAS ]; then
        echo "Please enter the robot alias"
    else
	ssh $toadi mkdir -p /home/toadi/data/toadi/lib \
        && scp ~/toadi-main/sdk/jetson/linux/lib/libSlamCore.so $toadi:/home/toadi/data/toadi/lib
    fi
}

toadi-remote-cleanup-with-port () {
    # Copies over the sdk-version of SLAM to remote toadi
    PORT=$1
    toadi=root@10.55.0.146
    if [ -z $PORT ]; then
        echo "Please enter the port number"
    else
	ssh $toadi -p $PORT mkdir -p /home/toadi/data/toadi/lib \
        && scp -r -P $PORT ~/toadi-main/sdk/jetson/linux/lib/libSlamCore.so $toadi:/home/toadi/data/toadi/lib \
        && scp -r -P $PORT ~/toolchain/tc-jetson-nano/aarch64-poky-linux/usr/lib/libboost_system.so* $toadi:/home/toadi/data/toadi/lib
    fi
}

toadi-get-sdk () {
    # a brute force way to checkout the desired commit hash of the toadi-sdk
    COMMIT_HASH=$1
    if [ -z $COMMIT_HASH ]; then
        echo "Please enter the commit hash"
    else
        echo "Checking out $COMMIT_HASH branch of toadi-sdk"
        cd ~/toadi-main/sdk
        git remote add toadi-sdk ssh://git@10.55.0.177:10022/toadi/toadi-sdk.git
        git fetch toadi-sdk
	git reset --hard
        git checkout toadi-sdk/sdk-$COMMIT_HASH
        git reset --hard
        cd -
    fi
}

toadi-find-string-in-files () {
    SEARCH_STRING=$1
    FILE_NAME_STRING=$2
    if [ -z $FILE_NAME_STRING ]; then
        echo "Syntax: toadi-find-string-in-files <string-to-search> <part-of-filename>"
    else
        find . -name "*$FILE_NAME_STRING*" -exec grep -l $SEARCH_STRING {} +
    fi
}

qt () {
    open -a $HOME/Qt/Qt\ Creator.app
}

find-the-frigging-toadi () {
    mkdir -p ~/Downloads/toadi-images;

    echo "IP scanning"

    nmap -snP 10.50.0.0/24 |  awk '/(10.50.0.[0-9][0-9])/{print $5}' > ~/Downloads/toadi-images/ips.txt;

    echo "Scanning completed and IPs saved to ~/Downloads/toadi-images/ips.txt"

    while read p; do
        echo "downloading http://$p:8080/image/front/img.jpg"
        cd ~/Downloads/toadi-images/
        curl -o "$p.jpg" "http://$p:8080/image/front/img.jpg"
        cd -
    done <~/Downloads/toadi-images/ips.txt
}

toadi-copy-simulator-stuff() {
    # Copies over the sdk-version of SLAM to remote toadi
    ROBOT_ALIAS=$1
    toadi=$ROBOT_ALIAS
    if [ -z $ROBOT_ALIAS ]; then
        echo "Please enter the robot alias"
    else
        echo "copying from port $toadi"

        for filename in $filenames; do
            scp -r $toadi:/home/toadi/data/*json* .
            scp -r $toadi:/home/toadi/data/*config* .
            scp -r $toadi:/home/toadi/data/maps .
            scp -r $toadi:/home/toadi/data/tunnelport .
        done
    fi
}
