# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/nvidia/nvidia-1.0.2313.ebuild,v 1.6 2002/01/23 18:55:20 azarah Exp $

#NOTE: devfs support is already included, so we dont have to patch the
#      kernel modules's source anymore !

MYV=${PV/0./0-}
S=${WORKDIR}
DESCRIPTION="High-performance nvidia graphics drivers for X, along with OpenGL 1.3"
SRC_URI="http://205.158.109.140/XFree86_40/${MYV}/NVIDIA_GLX-${MYV}.tar.gz
	http://205.158.109.140/XFree86_40/${MYV}/NVIDIA_kernel-1.0-2314.tar.gz"
HOMEPAGE="http://www.nvidia.com/"

DEPEND="virtual/glibc"

#might be good to roll this into Portage at some point.
KV=`readlink /usr/src/linux`
if [ $? -ne 0 ]
then
	echo 
	echo "/usr/src/linux symlink does not exist; cannot continue."
	echo
	exit 1
fi
KV=${KV/linux-/}


src_compile() {

	cd ${S}/NVIDIA_kernel-1.0-2314 #${MYV}
	make KERNDIR="${KV}" NVdriver
}

src_install () {

	cd ${S}/NVIDIA_kernel-1.0-2314 #${MYV}
	insinto /lib/modules/${KV}/kernel/video
	doins NVdriver
	
	cd ${S}/NVIDIA_GLX-${MYV}
	dodir /usr/lib /usr/X11R6/lib/modules/drivers /usr/X11R6/lib/modules/extensions /usr/include
	dolib.so usr/lib/libGL.so.${PV} usr/lib/libGLcore.so.${PV} 
	install usr/X11R6/lib/modules/drivers/nvidia_drv.o ${D}/usr/X11R6/lib/modules/drivers
	install usr/X11R6/lib/modules/extensions/libglx.so.${PV} ${D}/usr/X11R6/lib/modules/extensions
	( cd ${D}/usr/lib; ln -s libGL.so.${PV} libGL.so )
	( cd ${D}/usr/X11R6/lib/modules/extensions; [ -f libglx.so.${PV} ] && ln -s libglx.so.${PV} libglx.so)
	insinto /usr/include/GL
	doins usr/include/GL/*
	dodoc usr/share/doc/*
}

pkg_preinst() {
	rm -f ${ROOT}/usr/lib/libGL.so*
	rm -f ${ROOT}/usr/lib/libGLcore.so*
	rm -f ${ROOT}/usr/X11R6/lib/modules/extensions/libGLcore.*
	rm -f ${ROOT}/usr/X11R6/lib/modules/extensions/libglx.*
	einfo "Moving old libGL stuff in ${ROOT}/usr/X11R6/lib into an \"old\" directory."	
	cd ${ROOT}/usr/X11R6/lib
	[ ! -d old ] && mkdir old
	#fix problem where if libGL.* do not exist, emerge fails
	for x in `ls libGL.*`
	do
		[ -e ${x} ] && mv ${x} old
	done
}

pkg_postinst() {
	#fix first time load
	[ "$ROOT" = "/" ] && depmod -a
}
