# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ati-drivers/ati-drivers-3.7.0.ebuild,v 1.1 2003/12/30 01:20:13 azarah Exp $

IUSE="qt kde gnome"

inherit eutils rpm

DESCRIPTION="Ati precompiled drivers for r350, r300, r250 and r200 chipsets"
HOMEPAGE="http://www.ati.com"
SRC_URI="http://www2.ati.com/drivers/linux/fglrx-glc22-4.3.0-${PV}.i386.rpm"
SLOT="${KV}"
LICENSE="ATI GPL-2 QPL-1.0"
KEYWORDS="-* ~x86"

DEPEND=">=virtual/linux-sources-2.4
	app-arch/rpm2targz
	>=x11-base/xfree-4.3.0
	qt? ( >=x11-libs/qt-3.0 )"

RDEPEND="qt? ( >=x11-libs/qt-3.0 )"

ATIBIN="${D}/opt/ati/bin"
RESTRICT="nostrip"

src_unpack() {
	local OLDBIN="/usr/X11R6/bin"

	cd ${WORKDIR}
	rpm_src_unpack

	mkdir -p ${WORKDIR}/extra
	einfo "Unpacking fglrx_sample_source.tgz..."
	tar --no-same-owner -C ${WORKDIR}/extra/ -zxf \
		${WORKDIR}/usr/src/ATI/fglrx_sample_source.tgz \
		|| die "Failed to unpack fglrx_sample_source.tgz!"
	# Defining USE_GLU allows this to compile with NVIDIA headers just fine
	sed -e "s:-I/usr/X11R6/include:-D USE_GLU -I/usr/X11R6/include:" \
		-i ${WORKDIR}/extra/fgl_glxgears/Makefile.Linux || die

	mkdir -p ${WORKDIR}/extra/fglrx_panel
	einfo "Unpacking fglrx_panel_sources.tgz..."
	tar --no-same-owner -C ${WORKDIR}/extra/fglrx_panel/ -zxf \
		${WORKDIR}/usr/src/ATI/fglrx_panel_sources.tgz \
		|| die "Failed to unpack fglrx_panel_sources.tgz!"
	sed -e "s:"${OLDBIN}":"${ATIBIN}":"\
		-i ${WORKDIR}/extra/fglrx_panel/Makefile

	# Messed up fglrx_panel headers
	cd ${WORKDIR}/extra/fglrx_panel
	epatch ${FILESDIR}/fglrx-3.7.0-fix-fglrx_panel-includes.patch

	cd ${WORKDIR}/lib/modules/fglrx/build_mod
	epatch ${FILESDIR}/fglrx-3.2.8-fix-amd-adv-spec.patch

	if [ "`echo ${KV}|grep 2.6`" ]
	then
		epatch ${FILESDIR}/fglrx-2.6-vmalloc-vmaddr.patch
#		epatch ${FILESDIR}/fglrx-2.6-iminor.patch
#		epatch ${FILESDIR}/3.2.5-linux-2.6.0-test6-mm.patch
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
		make -C /usr/src/linux SUBDIRS="`pwd`" modules || \
			ewarn "DRM module not built"
	    ARCH=${GENTOO_ARCH}
	else
		export _POSIX2_VERSION="199209"
		# That is the dirty way to avoid the id -u check
		sed -e 's:`id -u`:0:' \
			-e 's:`uname -r`:${KV}:' \
			-i make.sh
		./make.sh || ewarn "DRM module not built"
	fi

	einfo "Building the fgl_glxgears sample..."
	cd ${WORKDIR}/extra/fgl_glxgears
	make -f Makefile.Linux || ewarn "fgl_glxgears sample not build!"

	if [ "`use qt`" ]
	then
		einfo "Building the QT fglx panel..."
		cd ${WORKDIR}/extra/fglrx_panel
		emake || die
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

	# Apps
	insinto /etc/env.d
	doins ${FILESDIR}/09ati
	exeinto /opt/ati/bin
	doexe ${WORKDIR}/extra/fgl_glxgears/fgl_glxgears
	doexe ${WORKDIR}/usr/X11R6/bin/*
	rm -f ${WORKDIR}/usr/X11R6/bin/*

	if [ "`use qt`" ]
	then
		doexe ${WORKDIR}/extra/fglrx_panel/fireglcontrol
	else
		# Removing unused stuff
		rm -rf ${WORKDIR}/usr/share/{applnk,gnome,icons,pixmaps}
	fi

	dodoc ${WORKDIR}/usr/share/doc/fglrx/LICENSE.*

	# Removing unused stuff
	rm -rf ${WORKDIR}/usr/{src,share/doc}
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

