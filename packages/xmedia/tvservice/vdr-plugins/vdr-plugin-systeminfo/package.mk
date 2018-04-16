################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-present Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="vdr-plugin-systeminfo"
PKG_VERSION="0.1.4"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://firefly.vdr-developer.org/systeminfo"
PKG_URL="$PKG_SITE/vdr-systeminfo-$PKG_VERSION.tar.bz2"
PKG_SOURCE_DIR="systeminfo-${PKG_VERSION}"
PKG_DEPENDS_TARGET="toolchain vdr"
PKG_SECTION="xmedia/tvservice"
PKG_SHORTDESC="VDR plugin that displays system informations"
PKG_LONGDESC="VDR plugin that displays system informations."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"
PKG_LOCALE_INSTALL="yes"

make_target() {
  : # none
}

makeinstall_target() {
  make LIBDIR=/usr/lib/vdr \
       DESTDIR=$INSTALL \
       install
}

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/config/vdr/plugins/systeminfo
    cp $PKG_DIR/config/* $INSTALL/usr/config/vdr/plugins/systeminfo
}
