################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-present Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="libtool"
PKG_VERSION="2.4.6"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.gnu.org/software/libtool/"
PKG_URL="http://ftpmirror.gnu.org/libtool/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="ccache:host autoconf:host"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="devel"
PKG_SHORTDESC="libtool: Generic library support script"
PKG_LONGDESC="This is GNU Libtool, a generic library support script. Libtool hides the complexity of using shared libraries behind a consistent, portable interface."
PKG_IS_ADDON="no"

PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_HOST="--enable-static --disable-shared"
