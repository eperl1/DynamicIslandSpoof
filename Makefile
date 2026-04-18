ARCHS = arm64
TARGET = iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = SpringBoard

TWEAK_NAME = DynamicIslandSpoof
DynamicIslandSpoof_FILES = Tweak.m
DynamicIslandSpoof_CFLAGS = -fobjc-arc
DynamicIslandSpoof_FRAMEWORKS = UIKit Foundation CoreFoundation

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk
