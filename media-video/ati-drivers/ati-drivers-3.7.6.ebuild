# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ati-drivers/ati-drivers-3.7.6.ebuild,v 1.7 2004/07/26 20:34:40 spyderous Exp $

IUSE=""

inherit eutils rpm

DESCRIPTION="Ati precompiled drivers for r350, r300, r250 and r200 chipsets"
HOMEPAGE="http://www.ati.com"
SRC_URI="http://www2.ati.com/drivers/linux/fglrx-4.3.0-${PV}.i386.rpm"
SLOT="${KV}"
LICENSE="ATI"
KEYWORDS="-* ~x86"

DEPEND=">=virtual/linux-sources-2.4
	app-arch/rpm2targz
	>=x11-base/xfree-4.3.0"

RDEPEND=">=x11-base/xfree-4.3.0"

ATIBIN="${D}/opt/ati/bin"
RESTRICT="nostrip"

src_unpack() {
	local OLDBIN="/usr/X11R6/bin"

	cd ${WORKDIR}
	rpm_src_unpack

	cd ${WORKDIR}/lib/modules/fglrx/build_mod

	if [ "`echo ${KV}|grep 2.6`" ]
	then
		epatch ${FILESDIR}/fglrx-2.6-vmalloc-vmaddr.patch
	fi
}

pkg_setup(){
	check_KV || \
		die "Please ensure /usr/src/linux points to your kernel symlink!"
}

src_compile() {
	local GENTOO_ARCH=

	einfo "Building the DRM module..."
	cd ${WORKDIR}/lib/modules/fglrx/build_mod
	if [ "${KV}" != "${KV/2\.6}" ]
	then
		GENTOO_ARCH=${ARCH}
		unset ARCH
	    addwrite "/usr/src/${FK}"
	    cp 2.6.x/Makefile .
		export _POSIX2_VERSION="199209"
		make -C ${ROOT}/usr/src/linux SUBDIRS="`pwd`" modules || \
			ewarn "DRM module not built"
	    ARCH=${GENTOO_ARCH}
	else
		export _POSIX2_VERSION="199209"
		# That is the dirty way to avoid the id -u check
		sed -e 's:`id -u`:0:' \
			-e 's:`uname -r`:${KV}:' \
			-i make.sh
		chmod +x make.sh
		./make.sh || die "DRM module not built"
	fi

	# Removing unused stuff
	rm -rf ${WORKDIR}/usr/X11R6/bin/{*.bz2,fgl_glxgears}
}

pkg_preinst() {
	# Clean the dinamic libGL stuff's home to ensure
	# we don't have stale libs floating around ...
	if [ -d "${ROOT}/usr/lib/opengl/ati" ]
	then
		rm -rf ${ROOT}/usr/lib/opengl/ati/*
	fi
}

src_install() {
	local ATI_ROOT="/usr/lib/opengl/ati"

	cd ${WORKDIR}

	# DRM module
	insinto /lib/modules/${KV}/video
	if [ "${KV}" != "${KV/2\.6}" ]
	then
		doins ${WORKDIR}/lib/modules/fglrx/build_mod/fglrx.ko
	else
		doins ${WORKDIR}/lib/modules/fglrx/build_mod/fglrx.o
	fi

	# OpenGL libs
	exeinto ${ATI_ROOT}/lib
	doexe ${WORKDIR}/usr/X11R6/lib/libGL.so.1.2
	dosym libGL.so.1.2 ${ATI_ROOT}/lib/libGL.so.1
	dosym libGL.so.1.2 ${ATI_ROOT}/lib/libGL.so
	dosym libGL.so.1.2 ${ATI_ROOT}/lib/libMesaGL.so
	# This is the same as that of xfree ...
	dosym ../../xfree/lib/libGL.la ${ATI_ROOT}/lib/libGL.la

	# X and DRI driver
	exeinto /usr/X11R6/lib/modules/drivers
	doexe ${WORKDIR}/usr/X11R6/lib/modules/drivers/fglrx_drv.o
	exeinto /usr/X11R6/lib/modules/dri
	doexe ${WORKDIR}/usr/X11R6/lib/modules/dri/fglrx_dri.so
	rm -f ${WORKDIR}/usr/X11R6/lib/modules/drivers/fglrx_drv.o \
		${WORKDIR}/usr/X11R6/lib/modules/dri/fglrx_dri.so

	# Same as in xfree
	exeinto ${ATI_ROOT}/
	dosym ../xfree/include ${ATI_ROOT}/include
	dosym ../xfree/extensions ${ATI_ROOT}/extensions
	rm -f ${WORKDIR}/usr/X11R6/lib/libGL.so.1.2

	dodoc ${WORKDIR}/usr/share/doc/fglrx/LICENSE.*

	#apps
	insinto /etc/env.d
	doins ${FILESDIR}/09ati
	exeinto /opt/ati/bin
	doexe usr/X11R6/bin/*
	rm usr/X11R6/bin/*

	# Removing unused stuff
	rm -rf ${WORKDIR}/usr/{src,share}
	cp -R ${WORKDIR}/usr ${D}/
}

pkg_postinst() {
# Ebuild shouldn't do this automatically, just tell the user to do it,
# otherwise it messes up livecd/gamecd stuff ...  (drobbins, 1 May 2003)
#	if [ "${ROOT}" = "/" ]
#	then
#		/usr/sbin/opengl-update ati
#	fi

	echo
	einfo "To switch to ATI OpenGL, run \"opengl-update ati\""
	einfo "To change your XF86Config you can use the bundled \"fglrxconfig\""
	echo

	# DRM module
	update-modules
}
