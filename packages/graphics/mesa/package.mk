################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-present Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="mesa"
PKG_VERSION="1e17346"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.mesa3d.org/"
PKG_URL="https://cgit.freedesktop.org/mesa/mesa/snapshot/$PKG_VERSION.tar.xz"
PKG_SOURCE_DIR="$PKG_VERSION"
PKG_DEPENDS_TARGET="toolchain expat libdrm Mako:host"
PKG_SECTION="graphics"
PKG_SHORTDESC="mesa: 3-D graphics library with OpenGL API"
PKG_LONGDESC="Mesa is a 3-D graphics library with an API which is very similar to that of OpenGL*. To the extent that Mesa utilizes the OpenGL command syntax or state machine, it is being used with authorization from Silicon Graphics, Inc. However, the author makes no claim that Mesa is in any way a compatible replacement for OpenGL or associated with Silicon Graphics, Inc. Those who want a licensed implementation of OpenGL should contact a licensed vendor. While Mesa is not a licensed OpenGL implementation, it is currently being tested with the OpenGL conformance tests. For the current conformance status see the CONFORM file included in the Mesa distribution."
PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

if [ "$DISPLAYSERVER" = "x11" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET glproto dri2proto presentproto libXext libXdamage libXfixes libXxf86vm libxcb libX11 dri3proto libxshmfence"
  export DRI_DRIVER_INSTALL_DIR=$XORG_PATH_DRI
  export DRI_DRIVER_SEARCH_DIR=$XORG_PATH_DRI
  export X11_INCLUDES=
  MESA_DRI="--enable-dri --enable-dri3"
  MESA_GLX="--enable-glx --enable-driglx-direct --enable-glx-tls"
  MESA_EGL_PLATFORMS="--with-platforms=x11,drm"
else
  MESA_DRI="--enable-dri --disable-dri3"
  MESA_GLX="--disable-glx --disable-driglx-direct --disable-glx-tls"
  MESA_EGL_PLATFORMS="--with-platforms=drm"
fi

# configure GPU drivers and dependencies:
  get_graphicdrivers

if [ "$LLVM_SUPPORT" = "yes" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET elfutils llvm"
  export LLVM_CONFIG="$SYSROOT_PREFIX/usr/bin/llvm-config-host"
  MESA_GALLIUM_LLVM="--enable-llvm --enable-llvm-shared-libs"
else
  MESA_GALLIUM_LLVM="--disable-llvm"
fi

if [ "$VDPAU_SUPPORT" = "yes" -a "$DISPLAYSERVER" = "x11" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libvdpau"
  MESA_VDPAU="--enable-vdpau"
else
  MESA_VDPAU="--disable-vdpau"
fi

XA_CONFIG="--disable-xa"
for drv in $GRAPHIC_DRIVERS; do
  [ "$drv" = "vmware" ] && XA_CONFIG="--enable-xa"
done

if [ "$OPENGLES_SUPPORT" = "yes" ]; then
  MESA_GLES="--disable-gles1 --enable-gles2"
else
  MESA_GLES="--disable-gles1 --disable-gles2"
fi

PKG_CONFIGURE_OPTS_TARGET="CC_FOR_BUILD=$HOST_CC \
                           CXX_FOR_BUILD=$HOST_CXX \
                           CFLAGS_FOR_BUILD= \
                           CXXFLAGS_FOR_BUILD= \
                           LDFLAGS_FOR_BUILD= \
                           --disable-debug \
                           --disable-mangling \
                           --enable-texture-float \
                           --enable-asm \
                           --disable-selinux \
                           --enable-opengl \
                           $MESA_GLES \
                           $MESA_DRI \
                           $MESA_GLX \
                           --disable-osmesa \
                           --disable-gallium-osmesa \
                           --enable-egl \
                           $MESA_EGL_PLATFORMS \
                           $XA_CONFIG \
                           --enable-gbm \
                           --disable-nine \
                           --disable-xvmc \
                           $MESA_VDPAU \
                           --disable-va \
                           --disable-opencl \
                           --enable-opencl-icd \
                           --disable-gallium-tests \
                           --enable-shared-glapi \
                           --enable-shader-cache \
                           $MESA_GALLIUM_LLVM \
                           --disable-silent-rules \
                           --with-gl-lib-name=GL \
                           --with-osmesa-lib-name=OSMesa \
                           --with-gallium-drivers=$GALLIUM_DRIVERS \
                           --with-dri-drivers=$DRI_DRIVERS \
                           --with-vulkan-drivers=intel,radeon \
                           --with-sysroot=$SYSROOT_PREFIX"

pre_configure_target() {
  export LIBS="-lxcb-dri3 -lxcb-dri2 -lxcb-xfixes -lxcb-present -lxcb-sync -lxshmfence -lz -lLLVM"
}

post_makeinstall_target() {
  # rename and relink to cooperate with nvidia drivers
    rm -rf $INSTALL/usr/lib/libGL.so
    rm -rf $INSTALL/usr/lib/libGL.so.1
    ln -sf libGL.so.1 $INSTALL/usr/lib/libGL.so
    ln -sf /var/lib/libGL.so $INSTALL/usr/lib/libGL.so.1
    mv $INSTALL/usr/lib/libGL.so.1.2.0 $INSTALL/usr/lib/libGL_mesa.so.1
}
