# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /space/gentoo/cvsroot/gentoo-x86/skel.build,v 1.14 2002/02/01 19:50:13 gbevin Exp

# This portage installs binary XFree drivers for video cards
# with NVIDIA chipsets.  The driver is provided by NVIDIA corporation.

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"

NV_V=1.0-2802

DESCRIPTION="Linux kernel module for the NVIDIA's X driver"
HOMEPAGE="http://www.nvidia.com/"

DEPEND="virtual/glibc
        >=x11-base/xfree-4.0.2
        >=media-video/nvidia-kernel-${PV}"
PROVIDE="virtual/opengl"

NV_PACKAGE=NVIDIA_glx-${NV_V}
SRC_URI="http://205.158.109.140/XFree86_40/${NV_V}/${NV_PACKAGE}.tar.gz"
S="${WORKDIR}/NVIDIA_GLX-${NV_V}"

src_install () {
    # NVIDIA's stock makefile overwrites headers and libraries
    # that come with XFree.  I don't like it and prefer to keep
    # NVIDIA's stuff in a totally separate place, hence it goes
    # into /opt
    local NV_ROOT=/opt/nvidia

    # The X module
    exeinto "${NV_ROOT}/modules/drivers"
    doexe "usr/X11R6/lib/modules/drivers/nvidia_drv.o"
    exeinto "${NV_ROOT}/modules/extensions"
    doexe "usr/X11R6/lib/modules/extensions/libglx.so.${PV}"
    dosym "${NV_ROOT}/modules/extensions/libglx.so.${PV}" \
          "${NV_ROOT}/modules/extensions/libglx.so"

    # The GLX libraries
    exeinto "${NV_ROOT}/lib"
    doexe usr/lib/libGL.so."${PV}"     \
          usr/lib/libGLcore.so."${PV}" \
          usr/X11R6/lib/libXvMCNVIDIA.a
    dosym "${NV_ROOT}/lib/libGL.so.${PV}"     "${NV_ROOT}/lib/libGL.so"
    dosym "${NV_ROOT}/lib/libGL.so.${PV}"     "${NV_ROOT}/lib/libGL.so.1"
    dosym "${NV_ROOT}/lib/libGLcore.so.${PV}" "${NV_ROOT}/lib/libGLcore.so"
    dosym "${NV_ROOT}/lib/libGLcore.so.${PV}" "${NV_ROOT}/lib/libGLcore.so.1"

    # Not sure whether installing the .la file is neccessary;
    # this is adopted from the `nvidia' ebuild
    local ver1="`echo ${PV} |cut -d '.' -f 1`"
    local ver2="`echo ${PV} |cut -d '.' -f 2`"
    local ver3="`echo ${PV} |cut -d '.' -f 3`"
    sed -e "s:\${PV}:${PV}:"     \
        -e "s:\${ver1}:${ver1}:" \
        -e "s:\${ver2}:${ver2}:" \
        -e "s:\${ver3}:${ver3}:" \
        "${FILESDIR}"/libGL.la > "${D}/${NV_ROOT}"/lib/libGL.la

    # Make sure /opt/NVIDIA/lib gets into ld.so.conf before xfree's libs
    insinto /etc/env.d
    doins "${FILESDIR}"/09nvidia

    # Includes
    insinto "${NV_ROOT}"/include/GL
    doins usr/include/GL/*.h

    # Docs
    dodoc usr/share/doc/* \
          "${FILESDIR}"/README.gentoo 
}

pkg_postinst() {
    einfo
    einfo "Make sure to read documentation in /doc/share/${P}"
    einfo "before you attempt to tweak your XF86Config file!"
    einfo
}
