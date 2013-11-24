#!/bin/sh

if [ $# = 1 ]; then
	case "$1" in
		"clean")
			MAKECLEAR=1
			MAKEIMG=0
			;;
		"image")
			MAKECLEAR=0
			MAKEIMG=1
			;;
    esac
fi  

if [ $MAKECLEAR = 1 ]; then
	rm -rf libs 2> /dev/null
    if [ $? != 0 ]; then
        exit 1
    fi						
fi

if [ $MAKEIMG = 1 ]; then
	ndk-build -C ./jni
    if [ $? != 0 ]; then
        exit 1
    fi
fi
