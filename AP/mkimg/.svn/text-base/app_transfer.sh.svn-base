#!/bin/sh

. ../../.config

########################################
# busybox
cp -af ../busybox_1.15.0/_install/bin/busybox $ANDROID_OUT/system/bin
cp -af ../busybox_1.15.0/_install/bin/mknod $ANDROID_OUT/system/bin

########################################
# led driver
if [ ! -d $ANDROID_OUT/system/lib/modules ]; then
	mkdir $ANDROID_OUT/system/lib/modules
fi
cp $AP/led_driver/led.ko $ANDROID_OUT/system/lib/modules

########################################
# Led_Control
cp $AP/Led_Control/bin/Led_Control.apk $ANDROID_OUT/system/app
cp $AP/Led_Control/libs/armeabi/libled.so $ANDROID_OUT/system/lib

########################################
# apk
cp $AP/apk/apkInstaller.apk $ANDROID_OUT/system/app

