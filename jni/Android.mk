LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := main
LOCAL_SRC_FILES := main.c  	# source code
APP_ABI := arm64-v8a 		# target platform (depends on device CPU)
TARGET_ARCH_ABI := arm64-v8a

include $(BUILD_EXECUTABLE) # compilation type - executable or library