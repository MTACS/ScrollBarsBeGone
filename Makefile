THEOS_DEVICE_IP = 10.0.0.151

ARCHS = arm64 arm64e

DEBUG = 0

FINALPACKAGE = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ScrollBarBeGone

ScrollBarBeGone_FILES = Tweak.xm
ScrollBarBeGone_FRAMEWORKS = UIKit
ScrollBarBeGone_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "sbreload"
