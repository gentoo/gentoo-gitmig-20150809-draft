# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Arcady Genkin <agenkin@thpoon.com>
# /space/gentoo/cvsroot/gentoo-x86/skel.build,v 1.14 2002/02/01 19:50:13 gbevin Exp

# This portage installs binary XFree drivers for video cards
# with NVIDIA chipsets.  The driver is provided by NVIDIA corporation.

S="${WORKDIR}/${P}"

DESCRIPTION="Linux kernel module for the NVIDIA's X driver"

NV_PACKAGE=NVIDIA_GLX-1.0-2313
NV_ARCHIVE="${NV_PACKAGE}.tar.gz"

SRC_URI="http://205.158.109.140/XFree86_40/1.0-2313/${NV_ARCHIVE}"
HOMEPAGE="http://www.nvidia.com/"

DEPEND="virtual/glibc >=x11-base/xfree-4.0.2 >=media-video/nvidia-kernel-1.0.2314"

src_unpack() {
        unpack "${NV_ARCHIVE}"
        mv "${NV_PACKAGE}" "${P}"
}

src_install () {
        # NVIDIA's stock makefile overwrites headers and libraries
        # that come with XFree.  I don't like it and prefer to keep
        # NVIDIA's stuff in a totally separate place, hence it goes
        # into /opt
        local NVIDIA_ROOT=/opt/nvidia

        # The X module
        exeinto "${NVIDIA_ROOT}/modules/drivers"
        doexe usr/X11R6/lib/modules/drivers/nvidia_drv.o
        exeinto "${NVIDIA_ROOT}/modules/extensions"
        doexe "usr/X11R6/lib/modules/extensions/libglx.so.${PV}"
        (cd "${D}/${NVIDIA_ROOT}/modules/extensions"
         ln -s "libglx.so.${PV}" libglx.so)

        # The GLX libraries
        exeinto "${NVIDIA_ROOT}/lib"
        doexe "usr/lib/libGL.so.${PV}" "usr/lib/libGLcore.so.${PV}"
        (cd "${D}/${NVIDIA_ROOT}/lib"
         ln -s "libGL.so.${PV}"     libGL.so
         ln -s "libGL.so.${PV}"     libGL.so.1
         ln -s "libGLcore.so.${PV}" libGLcore.so
         ln -s "libGLcore.so.${PV}" libGLcore.so.1)
        
        # Not sure whether installing the .la file is neccessary;
        # this is adopted from the `nvidia' ebuild
        local ver1="`echo ${PV} |cut -d '.' -f 1`"
        local ver2="`echo ${PV} |cut -d '.' -f 2`"
        local ver3="`echo ${PV} |cut -d '.' -f 3`"
        sed -e "s:\${PV}:${PV}:"     \
            -e "s:\${ver1}:${ver1}:" \
            -e "s:\${ver2}:${ver2}:" \
            -e "s:\${ver3}:${ver3}:" \
            "${FILESDIR}/libGL.la" > "${D}/${NVIDIA_ROOT}/lib/libGL.la"

        # Make sure /opt/NVIDIA/lib gets into ld.so.conf before xfree's libs
        insinto /etc/env.d
        doins "${FILESDIR}/09nvidia"

        # Includes
        insinto "${NVIDIA_ROOT}/include/GL"
        doins usr/include/GL/*.h

        # Docs
        dodoc "${FILESDIR}/README.gentoo" usr/share/doc/*
}

pkg_postinst() {
        einfo
        einfo "Make sure to read documentation in /doc/share/${P}"
        einfo "before you attempt to tweak your XF86Config file!"
        einfo
}
