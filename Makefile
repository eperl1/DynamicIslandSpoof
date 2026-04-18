ARCHS = arm64
TARGET = iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = SpringBoard

TWEAK_NAME = DynamicIslandSpoof
DynamicIslandSpoof_FILES = Tweak.m fishhook.c

DynamicIslandSpoof_CFLAGS = -fobjc-arc

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk
