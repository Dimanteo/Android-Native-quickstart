## Simple way to create native console application for Android  
### Requirements  
1. [NDK](https://developer.android.com/ndk/downloads) - android native development kit. Contains toolchains for cross-compiling your C++ code for ARM CPUs.
2. [ADB](https://developer.android.com/studio/releases/platform-tools) - this is part of android SDK platfor-tools. It allows you to install, run and debug your application on your android device from your home OS.
3. Android device with USB debugging allowed.
### Minimal native app  
Besides source code of our application we will need *Android.mk*, which is make file file for `ndk-build` tool.  
First create a project directory. Then inside that directory create a subdirectory, called `jni` (Java-Native-Interface).  
Inside this subdirectory put source code of your native application. In my case this file will be called `main.c`.
```C++
#include <stdio.h>

int main()
{
    printf("Friendship ended with Java.\n"
           "Now C++ is my best friend.\n");
    return 0;
}
```
Now create file `Android.mk` in the same `jni` directory. Documentation about format of this file can be found [here](https://developer.android.com/ndk/guides/android_mk.html). I will provide minimal working example.
```
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := main
LOCAL_SRC_FILES := main.c  	# source code
TARGET_ARCH_ABI := arm64-v8a

include $(BUILD_EXECUTABLE) # compilation type - executable or library
```
When source code and Android.mk are ready, open terminal in your project directory and use `ndk-build`.  
```
NativeApp$ $PATH_TO_NDK/ndk-build
[arm64-v8a] Compile        : main <= main.c
[arm64-v8a] Executable     : main
[arm64-v8a] Install        : main => libs/arm64-v8a/main
```
`$PATH_TO_NDK` here is path to NDK installation directory.  
Two new subdirectories should appear in your project directory - libs/ and obj/. Executable is in `libs/$ABI`, where `$ABI` is abi of target device.  
Next step is to move app to device and run it. For installing executable use `adb push`. For running executable use `adb shell`.
```
NativeApp$ adb push . /data/local/tmp
NativeApp$ adb shell
crownlte:/ $ cd /data/local/tmp
crownlte:/data/local/tmp $ ./libs/arm64-v8a/main
Friendship ended with Java.
Now C++ is my best friend
```
### Clone code
This repository contains template for creating simple android native console applications.