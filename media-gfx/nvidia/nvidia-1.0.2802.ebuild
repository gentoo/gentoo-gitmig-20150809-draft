# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author:  Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/nvidia/nvidia-1.0.2802.ebuild,v 1.1 2002/03/07 22:26:07 azarah Exp $

#NOTE: devfs support is already included, so we dont have to patch the
#      kernel modules's source anymore !

MYV=${PV/1.0./1.0-}
S=${WORKDIR}
DESCRIPTION="High-performance nvidia graphics drivers for X, along with OpenGL 1.3"
SRC_URI="http://205.158.109.140/XFree86_40/${MYV}/NVIDIA_GLX-${MYV}.tar.gz
	http://205.158.109.140/XFree86_40/${MYV}/NVIDIA_kernel-${MYV}.tar.gz"
HOMEPAGE="http://www.nvidia.com/"

DEPEND="virtual/glibc
	virtual/x11"

get_KV() {

	KV="`readlink /usr/src/linux`"
	if [ $? -ne 0 ]
	then
		echo 
		echo "/usr/src/linux symlink does not exist; cannot continue."
		echo
		exit 1
	fi
	KV="${KV/linux-/}"
}	

src_compile() {

	get_KV

	cd "${S}/NVIDIA_kernel-${MYV}"
	make KERNDIR="${KV}" NVdriver || die
}

src_install() {

	get_KV

	cd "${S}/NVIDIA_kernel-${MYV}"
	insinto "/lib/modules/${KV}/kernel/video"
	doins NVdriver
	
	cd "${S}/NVIDIA_GLX-${MYV}"
	dodir /usr/lib /usr/X11R6/lib/modules/drivers \
		/usr/X11R6/lib/modules/extensions /usr/include
	dolib.so "usr/lib/libGL.so.${PV}" "usr/lib/libGLcore.so.${PV}"
	into /usr/X11R6/lib/modules/drivers
	dolib.so usr/X11R6/lib/modules/drivers/nvidia_drv.o
	into /usr/X11R6/lib/modules/extensions
	dolib.so "usr/X11R6/lib/modules/extensions/libglx.so.${PV}"
	( cd ${D}/usr/lib; ln -s libGL.so.${PV} libGL.so )
	( cd ${D}/usr/X11R6/lib/modules/extensions; \
	  [ -f "libglx.so.${PV}" ] && ln -s "libglx.so.${PV}" libglx.so )
	  
	insinto /usr/include/GL
	doins usr/include/GL/*
	
	into /
	newsbin "${S}/NVIDIA_kernel-${MYV}/makedevices.sh" NVmakedevices.sh
	
	dodoc usr/share/doc/*

	# generate libtool .la file
	local ver1="`echo $PV |cut -d '.' -f 1`"
	local ver2="`echo $PV |cut -d '.' -f 2`"
	local ver3="`echo $PV |cut -d '.' -f 3`"
	sed -e "s:\${PV}:${PV}:" \
		-e "s:\${ver1}:${ver1}:" \
		-e "s:\${ver2}:${ver2}:" \
		-e "s:\${ver3}:${ver3}:" \
		"${FILESDIR}/libGL.la" > "${D}/usr/lib/libGL.la"
}

pkg_preinst() {

	get_KV

	rm -f ${ROOT}/usr/lib/libGL.so*
	rm -f ${ROOT}/usr/lib/libGLcore.so*
	if [ -d "${ROOT}/usr/X11R6/lib" ]
	then
		einfo "Moving old libGL stuff in ${ROOT}/usr/X11R6/lib into an \"old\" directory."
		cd "${ROOT}/usr/X11R6/lib"
		[ ! -d old ] && mkdir old
		#fix problem where if libGL.* do not exist, emerge fails
		( for x in `ls libGL.*`
		do
			if [ -e "${x}" ]
			then
				mv "${x}" "${ROOT}/usr/X11R6/lib/old"
			fi
		done
		) >/dev/null 2>&1
	fi
	if [ -d "${ROOT}/usr/X11R6/lib/modules/extensions" ]
	then
		einfo "Moving old libGLcore/libglx stuff in ${ROOT}/usr/X11R6/lib/modules/extensions"
		einfo "into an \"old\" directory."
		cd "${ROOT}/usr/X11R6/lib/modules/extensions"
		[ ! -d old ] && mkdir old
		( for x in `ls libGLcore.*` `ls libglx.*`
		do
			if [ -e "${x}" ]
			then
				mv "${x}" "${ROOT}/usr/X11R6/lib/modules/extensions/old"
			fi
		done
		) >/dev/null 2>&1
	fi
}

pkg_postinst() {

	#fix first time load
	if [ "${ROOT}" = "/" ]
	then
		[ -x /usr/sbin/update-modules ] && /usr/sbin/update-modules >/dev/null 2>&1
		[ -x /sbin/rmmod ]              && /sbin/rmmod NVdriver >/dev/null 2>&1
		[ -x /sbin/depmod ]             && /sbin/depmod -a >/dev/null 2>&1
		[ -x /sbin/NVmakedevices.sh ]   && /sbin/NVmakedevices.sh >/dev/null 2>&1
	fi
	einfo "Old libGL stuff is in ${ROOT}/usr/X11R6/lib/old/."
	einfo "Old libGLcore/libglx stuff is in ${ROOT}/usr/X11R6/lib/modules/extensions/old/."
}

