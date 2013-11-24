#!/bin/bash

###################################################
# by Pirlo on 2011/08/04
###################################################

. ./.config

CPU_JOB_NUM=`cat /proc/cpuinfo| grep processor| awk '{field=$NF};END{print field+1}'`

###################################################
# Install_JDK

install_JDK() {
	sudo add-apt-repository "deb http://archive.canonical.com/ lucid partner"
	sudo add-apt-repository "deb-src http://archive.canonical.com/ubuntu lucid partner"
	sudo apt-get update
	sudo apt-get -y install sun-java6-jdk
	
	echo ""
	echo -e "\E[33mDon't forget to add the following line to ~/.bash_profile \
	\nexport JAVA_HOME=/usr/lib/jvm/java-6-sun \
	\nexport CLASSPATH=.:\$JAVA_HOME/lib:\$JAVA_HOME/jre/lib \
	\nPATH=\$PATH:\$JAVA_HOME/bin\e[0m"
	echo ""
}

###################################################
# Install_tools

install_tools() {
	sudo apt-get -y install git-core curl gnupg flex bison gperf \
		libc6-dev libsdl1.2-dev libesd0-dev libwxgtk2.6-dev zlib1g-dev \
		x11proto-core-dev libreadline5-dev libx11-dev libgl1-mesa-dev \
		g++-multilib mingw32 gawk build-essential libncurses5-dev
}

###################################################
# Install_NDK

install_NDK() {
	if [ -d /opt/android-ndk-r6b ]; then
		echo ""
		echo -e "\E[33mNDK has been installed.\e[0m"
	else
		cd $SDK
		tar -jxvf android-ndk-r6b-linux-x86.tar.bz2 -C /opt
	fi
	
	echo ""
	echo -e "\E[33mDon't forget to add the following line to ~/.bash_profile \
	\nexport NDK_ROOT=/opt/android-ndk-r6b \
	\nexport PATH=\$PATH:\$NDK_ROOT\e[0m"
	echo ""
}

###################################################
# Build_Android

build_android() {
	cd $ANDROID_SOURCE
	export TARGET_PRODUCT=$SEC_PRODUCT

	rm -rf $ANDROID_OUT/system.img 2> /dev/null
	rm -rf $ANDROID_OUT/obj/PACKAGING/systemimage_unopt_intermediates/system.img 2> /dev/null

	echo ""
	echo '########## Build android platform ##########'
	echo ""
	
	START_TIME=`date +%s`
	echo make -j$CPU_JOB_NUM
	make -j$CPU_JOB_NUM

	if [ $? != 0 ]; then
		exit $?
	fi

	END_TIME=`date +%s`
    let "ELAPSED_TIME=$END_TIME-$START_TIME"
	echo ""
    echo "Total compile time is $ELAPSED_TIME seconds"
}

###################################################
# Build_App

build_app() {
	if [ ! -d $ANDROID_OUT/system ]; then
		echo ""
		echo -e "\E[33mPlease run Build_Android at least one time.\e[0m"
		echo ""
		exit 1;
	fi
	
	cd $AP
	. DoApp.sh image
}

###################################################
# Make_Image

make_image() {
	if [ ! -e $ANDROID_OUT/system.img -o ! -e $ANDROID_OUT/ramdisk.img -o ! -e $ANDROID_OUT/userdata.img ]; then
		echo ""
		echo -e "\E[33mPlease run Build_Android at least one time.\e[0m"
		echo ""
		exit 1;
	fi

	echo ""
	echo '########## Make Image ##########'
	echo ""

	cd $IMAGE

	rm -f ./ramdisk-uboot.img 2> /dev/null
	rm -f ./system.img 2> /dev/null
	rm -f ./userdata.img 2> /dev/null

	cp $ANDROID_OUT/system.img $IMAGE
	cp $ANDROID_OUT/ramdisk.img $IMAGE
	cp $ANDROID_OUT/userdata.img $IMAGE

	./mkimage -A arm -O linux -T ramdisk -C none -a 0x50800000 -n "ramdisk" -d ramdisk.img ramdisk-uboot.img

	rm -rf ramdisk.img 2> /dev/null
}

###################################################
# Create Menu

clear
echo ""
echo "*******************************************************************"
echo "*                                                                 *"
echo "*           DMA6410L SDK Build System for Android 1.6             *"
echo "*                                                                 *"
echo "*            Copyright(C) 2011 www.ittraining.com.tw              *"
echo "*                                                                 *"
echo "*                      All Rights Reserved.                       *"
echo "*                                                                 *"		
echo "*******************************************************************"

OPTIONS="Install_JDK \
		 Install_tools \
		 Install_NDK \
		 Build_Android \
		 Build_App \
		 Make_Image \
		 Quit"
echo "-------------------------------------------------------------------"

select opt in $OPTIONS; do
	if [ "$opt" = "Install_JDK" ]; then
    	install_JDK
		exit
	elif [ "$opt" = "Install_tools" ]; then
		install_tools
		exit
	elif [ "$opt" = "Install_NDK" ]; then
		install_NDK
		exit
	elif [ "$opt" = "Build_Android" ]; then
		build_android
		exit
	elif [ "$opt" = "Build_App" ]; then
		build_app
		exit
	elif [ "$opt" = "Make_Image" ]; then
		make_image
		exit
	elif [ "$opt" = "Quit" ]; then
		clear
		echo "ByeBye..."
		exit 
	else
		clear
		echo "Bad option"
		exit
   fi
done

