# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ati-drivers/ati-drivers-8.8.25.ebuild,v 1.4 2005/01/19 12:49:40 lu_zero Exp $

IUSE="multilib" #doc

inherit eutils rpm multilib linux-info linux-mod

DESCRIPTION="Ati precompiled drivers for r350, r300, r250 and r200 chipsets"
HOMEPAGE="http://www.ati.com"
SRC_URI="x86? ( http://www2.ati.com/drivers/linux/fglrx_6_8_0-${PV}-1.i386.rpm )
		 amd64?
		 ( http://www2.ati.com/drivers/linux/fglrx64_6_8_0-${PV}-1.x86_64.rpm )"

LICENSE="ATI"
KEYWORDS="-* ~x86 ~amd64"

DEPEND=">=virtual/linux-sources-2.4
		>=x11-base/xorg-x11-6.8.0"

RDEPEND=">=x11-base/xorg-x11-6.8.0"
PROVIDE="virtual/opengl"

ATIBIN="${D}/opt/ati/bin"
RESTRICT="nostrip"

pkg_setup(){
	#check kernel and sets up KV_OBJ
	linux-mod_pkg_setup
	# Set up X11 implementation
	X11_IMPLEM_P="$(best_version virtual/x11)"
	X11_IMPLEM="${X11_IMPLEM_P%-[0-9]*}"
	X11_IMPLEM="${X11_IMPLEM##*\/}"
	einfo "X11 implementation is ${X11_IMPLEM}."
}

src_unpack() {
	local OLDBIN="/usr/X11R6/bin"

	cd ${WORKDIR}
	rpm_src_unpack

	cd ${WORKDIR}/lib/modules/fglrx/build_mod

	#epatch ${FILESDIR}/fglrx-3.9.0-allocation.patch

	if kernel_is 2 6
	then
		#epatch ${FILESDIR}/fglrx-2.6.10-pci_get_class.patch
		epatch ${FILESDIR}/8.08-kernel-2.6.10.patch
	fi

	rm -rf ${WORKDIR}/usr/X11R6/bin/fgl_glxgears
}

src_compile() {
	einfo "Building the DRM module..."
	cd ${WORKDIR}/lib/modules/fglrx/build_mod
	if kernel_is 2 6
	then
		set_arch_to_kernel
		addwrite "/usr/src/${FK}"
	    cp 2.6.x/Makefile .
		export _POSIX2_VERSION="199209"
		if use_m ;
		then
			make -C ${KV_DIR} M="`pwd`" modules || \
				ewarn "DRM module not built"
		else
			make -C ${KV_DIR} SUBDIRS="`pwd`" modules || \
				ewarn "DRM module not built"
		fi
	    set_arch_to_portage
	else
		export _POSIX2_VERSION="199209"
		# That is the dirty way to avoid the id -u check
		sed -e 's:`id -u`:0:' \
			-e 's:`uname -r`:${KV_FULL}:' \
			-i make.sh
		chmod +x make.sh
		./make.sh || die "DRM module not built"
	fi
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
	insinto /lib/modules/${KV_FULL}/video
	# set_kvobj
	doins ${WORKDIR}/lib/modules/fglrx/build_mod/fglrx.${KV_OBJ}

	local native_dir
	use x86 && native_dir="lib"
	use amd64 && native_dir="lib64"

	# OpenGL libs
	ATI_LIBS="${ATI_ROOT}/lib"
	exeinto ${ATI_LIBS}
	doexe ${WORKDIR}/usr/X11R6/${native_dir}/libGL.so.1.2
	dosym libGL.so.1.2 ${ATI_LIBS}/libGL.so.1
	dosym libGL.so.1.2 ${ATI_LIBS}/libGL.so
	dosym libGL.so.1.2 ${ATI_LIBS}/libMesaGL.so

	# X and DRI driver
	if has_version ">=x11-base/xorg-x11-6.8.0-r4"
	then
		local X11_DIR="/usr/"
	else
		local X11_DIR="/usr/X11R6/"
	fi

	local X11_LIB_DIR="${X11_DIR}$(get_libdir)"


	exeinto ${X11_LIB_DIR}/modules/drivers
	doexe ${WORKDIR}/usr/X11R6/${native_dir}/modules/drivers/fglrx_drv.o
	exeinto ${X11_LIB_DIR}/modules/dri
	doexe ${WORKDIR}/usr/X11R6/${native_dir}/modules/dri/fglrx_dri.so
	exeinto ${X11_LIB_DIR}/modules/linux
	doexe ${WORKDIR}/usr/X11R6/${native_dir}/modules/linux/libfglrxdrm.a

	# same as the xorg implementation
	dosym ../${X11_IMPLEM}/extensions ${ATI_ROOT}/extensions
	dosym ../../${X11_IMPLEM}/lib/libGL.la ${ATI_ROOT}/lib/libGL.la
	dosym ../${X11_IMPLEM}/include ${ATI_ROOT}/include

	#apps
	insinto /etc/env.d
	doins ${FILESDIR}/09ati
	exeinto /opt/ati/bin
	doexe usr/X11R6/bin/*

	#ati custom stuff
	cp -a ${WORKDIR}/usr/include ${D}/usr/include
	insinto /usr/X11R6/include/X11/extensions
	doins ${WORKDIR}/${X11_DIR}/include/X11/extensions/fglrx_gamma.h
	cp -a ${WORKDIR}/usr/X11R6/${native_dir}/libfglrx_gamma.* \
			${D}/${X11_LIB_DIR}

	if use multilib ; then
	einfo "Installing multilib support"
	X11_LIB_DIR="${X11_DIR}$(get_multilibdir)"

	insinto ${ATI_ROOT}/lib32
	doexe ${WORKDIR}/usr/X11R6/lib/libGL.so.1.2
	dosym libGL.so.1.2 ${ATI_ROOT}/lib32/libGL.so.1
	dosym libGL.so.1.2 ${ATI_ROOT}/lib32/libGL.so
	dosym libGL.so.1.2 ${ATI_ROOT}/lib32/libMesaGL.so

	exeinto ${X11_LIB_DIR}/modules/dri
	doexe ${WORKDIR}/usr/X11R6/lib/modules/dri/fglrx_dri.so
	fi

	#docs
#	if [ "`use doc`" ]
#	then
#	fi
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
	ewarn "***"
	ewarn "If you are experiencing problems with memory allocation try to add"
	ewarn "this line to in your X11 configuration file:"
	ewarn "		Option \"KernelModuleParm\"  \"agplock=0\" "
	ewarn "That should solve the hangups you could have with Neverwinter Nights"
	ewarn "***"
	# DRM module
	update-modules
}
