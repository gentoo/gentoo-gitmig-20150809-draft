# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/nvidia/nvidia-1.0.1541.ebuild,v 1.1 2001/10/06 06:06:11 drobbins Exp $

MYV=1.0-1541
DEVPATCH=nvidia_devfs-patch_1.0-1512.patch
S=${WORKDIR}
DESCRIPTION="High-performance nvidia graphics drivers for X, along with OpenGL 1.2"
SRC_URI="http://www.nvidia.com/docs/lo/1005/SUPP/NVIDIA_GLX-${MYV}.tar.gz http://www.nvidia.com/docs/lo/1017/SUPP/NVIDIA_kernel-${MYV}.tar.gz http://www.cyber.com.au/users/ashridah/${DEVPATCH}"
HOMEPAGE="http://www.nvidia.com"

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

src_unpack() {
	unpack NVIDIA_GLX-${MYV}.tar.gz NVIDIA_kernel-${MYV}.tar.gz 
	cd ${S}/NVIDIA_kernel-${MYV}
	#apply patch to add devfs support...
	patch -p1 < ${DISTDIR}/${DEVPATCH} || die
}

src_compile() {
	cd ${S}/NVIDIA_kernel-${MYV}
	make KERNDIR="${KV}" NVdriver
}

src_install () {
	cd ${S}/NVIDIA_kernel-${MYV}
	insinto /lib/modules/${KV}/kernel/video
	doins NVdriver
	cd ${S}/NVIDIA_GLX-${MYV}
	dodir /usr/lib /usr/X11R6/lib/modules/drivers /usr/X11R6/lib/modules/extensions /usr/include
	dolib.so usr/lib/libGL.so.${PV} usr/lib/libGLcore.so.${PV} 
	install usr/X11R6/lib/modules/drivers/nvidia_drv.o ${D}/usr/X11R6/lib/modules/drivers
	install usr/X11R6/lib/modules/extensions/libglx.so.${PV} ${D}/usr/X11R6/lib/modules/extensions
	( cd ${D}/usr/lib; ln -s libGL.so.${PV} libGL.so )
	( cd ${D}/usr/X11R6/lib/modules/extensions; ln -s libglx.so.${PV} libglx.so)
	insinto /usr/include/GL
	doins usr/include/GL/*
	dodoc usr/share/doc/*
}

pkg_preinst() {
	rm -f ${ROOT}/usr/lib/libGL.*
	rm -f ${ROOT}/usr/lib/libGLcore.*
	rm -f ${ROOT}/usr/X11R6/lib/modules/extensions/libGLcore.*
	rm -f ${ROOT}/usr/X11R6/lib/modules/extensions/libglx.*
}
