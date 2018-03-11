################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-present Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="xmedia"
PKG_VERSION=""
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.alexelec.in.ua"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="virtual"
PKG_SHORTDESC="xmedia: Metapackage"
PKG_LONGDESC=""
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

# tools
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET mc scan-m3u scan-s2"

# tv-services
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET oscam vdr"

# vdr-plugins
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET vdr-plugin-dvbapi"
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET vdr-plugin-epgsearch"
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET vdr-plugin-iptv"
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET vdr-plugin-softhddevice"

# torrents
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET acestream noxbit"
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET HTTPAceProxy"
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET transmission"
