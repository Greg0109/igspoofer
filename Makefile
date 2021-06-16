TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = Instagram Preferences


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = IGSpoofer

IGSpoofer_FILES = Tweak.x
IGSpoofer_FRAMEWORKS = UIKit
IGSpoofer_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += igspoofer
include $(THEOS_MAKE_PATH)/aggregate.mk
