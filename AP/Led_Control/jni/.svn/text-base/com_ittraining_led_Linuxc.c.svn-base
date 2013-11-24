#include <jni.h>
#include "com_ittraining_led_Linuxc.h"

#include <stdio.h>
#include <stdlib.h>	
#include <fcntl.h>
#include <errno.h>
#include <unistd.h>
#include <sys/ioctl.h>

//#include "led.h"
#define LED_TEST 3

#define DEVICE_BLTEST "/dev/led"      

int fd;

/*
 * Class:     com_ittraining_led_Linuxc
 * Method:    openled
 * Signature: ()I
 */
JNIEXPORT jint JNICALL Java_com_ittraining_led_Linuxc_openled
(JNIEnv *env, jclass mc)
{
 fd= open(DEVICE_BLTEST,O_RDONLY);
 return fd;
}

/*
 * Class:     com_ittraining_led_Linuxc
 * Method:    closeled
 * Signature: ()I
 */
JNIEXPORT jint JNICALL Java_com_ittraining_led_Linuxc_closeled
 (JNIEnv *env, jclass mc)
{
 close(fd);
}

/*
 * Class:     com_ittraining_led_Linuxc
 * Method:    send
 * Signature: (II)I
 */
JNIEXPORT jint JNICALL Java_com_ittraining_led_Linuxc_send
(JNIEnv *env, jclass mc, jint a, jint b)
{
 ioctl(fd,b,&a);               
}
