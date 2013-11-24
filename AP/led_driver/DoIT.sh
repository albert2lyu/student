#!/bin/sh

. ../../.config

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
	make clean
    if [ $? != 0 ]; then
        exit 1
    fi						
fi

if [ $MAKEIMG = 1 ]; then
	make 6410L_KERNEL_DIR=$LINUX_KERNEL CROSS_COMPILE=arm-linux-
    if [ $? != 0 ]; then
        exit 1
    fi
fi
