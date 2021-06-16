TARGET := iphone:clang:latest:7.0

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = IGSpoofer

IGSpoofer_FILES = IGSRootListController.m
IGSpoofer_FRAMEWORKS = UIKit
IGSpoofer_PRIVATE_FRAMEWORKS = Preferences
IGSpoofer_INSTALL_PATH = /Library/PreferenceBundles
IGSpoofer_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
