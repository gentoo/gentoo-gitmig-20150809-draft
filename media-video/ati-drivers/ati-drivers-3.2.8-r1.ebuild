# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ati-drivers/ati-drivers-3.2.8-r1.ebuild,v 1.5 2004/07/26 20:34:40 spyderous Exp $

IUSE=""

DESCRIPTION="Ati precompiled drivers for r350, r300, r250 and r200 chipsets"
HOMEPAGE="http://www.ati.com"
SRC_URI="http://www2.ati.com/drivers/linux/fglrx-glc22-4.3.0-${PV}.i586.rpm"
SLOT="${KV}"
LICENSE="ATI"
KEYWORDS="-* x86"

DEPEND=">=virtual/linux-sources-2.4
	app-arch/rpm2targz
	>=x11-base/xfree-4.3.0"

RDEPEND=">=x11-base/xfree-4.3.0"

ATIBIN="${D}/opt/ati/bin"
RESTRICT="nostrip"

src_unpack() {
	cd ${WORKDIR}
	rpm2targz ${DISTDIR}/${A} ||die
	tar zxf ${WORKDIR}/fglrx-glc22-4.3.0-${PV}.i586.tar.gz || die

	cd ${WORKDIR}/lib/modules/fglrx/build_mod

	einfo "applying fglrx-3.2.8-fix-amd-adv-spec.patch"
	patch < ${FILESDIR}/fglrx-3.2.8-fix-amd-adv-spec.patch

	if [ "`echo ${KV}|grep 2.6`" ] ; then

	einfo "applying fglrx-2.6-vmalloc-vmaddr.patch"
	patch -p1 < ${FILESDIR}/fglrx-2.6-vmalloc-vmaddr.patch
#	einfo "applying fglrx-2.6-iminor.patch"
#	patch -p1 < ${FILESDIR}/fglrx-2.6-iminor.patch
#	einfo "applying fglrx-2.6-tsk_euid.patch"
#	patch < ${FILESDIR}/3.2.5-linux-2.6.0-test6-mm.patch
	fi
}

pkg_setup(){
	check_KV || die "please ensure /usr/src/linux points to your kernel symlink"
}


src_compile() {
	einfo "building the glx module"
	cd ${WORKDIR}/lib/modules/fglrx/build_mod
	if [ "`echo ${KV}|grep 2.6`" ] ; then
		GENTOO_ARCH=${ARCH}
		unset ARCH
	    addwrite "/usr/src/${FK}"
	    cp 2.6.x/Makefile .
		export _POSIX2_VERSION=199209
		make -C ${ROOT}/usr/src/linux SUBDIRS="`pwd`" modules || \
	    ewarn "glx module not built"
	    ARCH=${GENTOO_ARCH}
	else
	#that is the dirty way to avoid the id -u check
	sed -e 's:`id -u`:0:' make.sh >make.sh.new
	sed -e 's:`uname -r`:${KV}:' make.sh.new >make.sh
	chmod +x make.sh
	./make.sh || die "glx module not built"
	fi

	#removing stuff
	einfo "cleaning"
	cd ${WORKDIR}
	rm -fR usr/share
	cd usr/X11R6/
	rm -fR bin/firegl*.bz2 bin/LICENSE.* bin/fgl_glxgears
}

pkg_preinst() {
# clean the dinamic libGL stuff's home to ensure
# we dont have stale libs floating around
	if [ -d ${ROOT}/usr/lib/opengl/ati ]
	then
		rm -rf ${ROOT}/usr/lib/opengl/ati/*
	fi
}

src_install() {
	local ATI_ROOT="/usr/lib/opengl/ati"
	cd ${WORKDIR}

#drm module
	insinto /lib/modules/${KV}/video
	if [ "`echo ${KV}|grep 2.6`" ] ; then
		doins lib/modules/fglrx/build_mod/fglrx.ko
	else
		doins lib/modules/fglrx/build_mod/fglrx.o
	fi

#dri driver
	exeinto ${ATI_ROOT}/lib
	doexe usr/X11R6/lib/libGL.so.1.2
	dosym libGL.so.1.2 ${ATI_ROOT}/lib/libGL.so.1
	dosym libGL.so.1.2 ${ATI_ROOT}/lib/libGL.so
	dosym libGL.so.1.2 ${ATI_ROOT}/lib/libMesaGL.so
	#that is the same as in the xfree
	dosym ../../xfree/lib/libGL.la ${ATI_ROOT}/lib/libGL.la

#same as in xfree
	exeinto ${ATI_ROOT}/
	dosym ../xfree/include ${ATI_ROOT}/include
	dosym ../xfree/extensions ${ATI_ROOT}/extensions
	rm usr/X11R6/lib/libGL.so.1.2

#apps
	insinto /etc/env.d
	doins ${FILESDIR}/09ati
	exeinto /opt/ati/bin
	doexe usr/X11R6/bin/*
	rm usr/X11R6/bin/*

	rm -fR usr/src/*
	cp -R usr ${D}
}

pkg_postinst() {
	#Ebuild shouldn't do this automatically, just tell the user to do it: (drobbins, 1 May 2003)
	#otherwise it messes up livecd/gamecd stuff
	#if [ "${ROOT}" = "/" ]
	#then
	#	/usr/sbin/opengl-update ati
	#fi

	einfo "To switch to ATI OpenGL, run \"opengl-update ati\""
	einfo "To change your XF86Config you can use the bundled \"fglrxconfig\""

	ewarn "This is a driver only ebuild, for the optional application please"
	ewarn "emerge ati-drivers-extra"
#drm-module
	update-modules

}
