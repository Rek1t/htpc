################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-present Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

# Downloadlocation:
# http://www.broadcom.com/support/802.11/linux_sta.php

PKG_NAME="bcm_sta"
PKG_VERSION="6.30.223.271"
PKG_ARCH="x86_64"
PKG_LICENSE="nonfree"
PKG_SITE="http://www.broadcom.com/"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_SECTION="driver"
PKG_SHORTDESC="bcm_sta: Broadcom's BCM4311-, BCM4312-, BCM4313-, BCM4321-, BCM4322-, BCM43224-, and BCM43225-based WLAN driver"
PKG_LONGDESC="These packages contain Broadcom's IEEE 802.11a/b/g/n hybrid Linux® device driver for use with Broadcom's BCM4311-, BCM4312-, BCM4313-, BCM4321-, BCM4322-, BCM43224-, and BCM43225-based hardware. There are different tars for 32-bit and 64-bit x86 CPU architectures. Make sure that you download the appropriate tar because the hybrid binary file must be of the appropriate architecture type. The hybrid binary file is agnostic to the specific version of the Linux kernel because it is designed to perform all interactions with the operating system through operating-system-specific files and an operating system abstraction layer file. All Linux operating-system-specific code is provided in source form, making it possible to retarget to different kernel versions and fix operating system related issues."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  cd x86-64
    KBUILD_NOPEDANTIC=1 make V=1 CC=$CC -C $(kernel_path) M=`pwd` BINARCH=$TARGET_KERNEL_ARCH
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/modules/$(get_module_dir)/bcm_sta
    cp *.ko $INSTALL/usr/lib/modules/$(get_module_dir)/$PKG_NAME
}
