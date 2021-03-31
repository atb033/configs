#!/bin/bash

toadi-remote-cleanup () {
    # Copies over the sdk-version of SLAM to remote toadi
    ROBOT_ID=$1
    toadi=root@10.50.0.$ROBOT_ID
    if [ -z $ROBOT_ID ]; then
        echo "Please enter the robot id"
    else
	ssh $toadi mkdir -p /home/toadi/data/toadi/lib \
        && scp ~/toadi-main/sdk/jetson/linux/lib/libSlamCore.so $toadi:/home/toadi/data/toadi/lib \
        && scp ~/toolchain/tc-jetson-nano/aarch64-poky-linux/usr/lib/libboost_system.so* $toadi:/home/toadi/data/toadi/lib
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
