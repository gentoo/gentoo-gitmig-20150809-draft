# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ati-drivers/ati-drivers-8.16.20.ebuild,v 1.1 2005/08/17 21:38:46 lu_zero Exp $

IUSE="opengl"

inherit eutils rpm multilib linux-info linux-mod toolchain-funcs

DESCRIPTION="Ati precompiled drivers for r350, r300, r250 and r200 chipsets"
HOMEPAGE="http://www.ati.com"
SRC_URI="x86? ( http://www2.ati.com/drivers/linux/fglrx_6_8_0-${PV}-1.i386.rpm )
	 amd64? ( http://www2.ati.com/drivers/linux/64bit/fglrx64_6_8_0-${PV}-1.x86_64.rpm )"

LICENSE="ATI"
KEYWORDS="-* ~amd64 ~x86"

RDEPEND=">=x11-base/xorg-x11-6.8.0
	 >=x11-base/opengl-update-2.1_pre1"

DEPEND=">=virtual/linux-sources-2.4
	${RDEPEND}"

PROVIDE="virtual/opengl"

ATIBIN="${D}/opt/ati/bin"
RESTRICT="nostrip multilib-pkg-force"

pkg_setup(){
	#check kernel and sets up KV_OBJ
	linux-mod_pkg_setup

	ebegin "Checking for MTRR support enabled"
	linux_chkconfig_present MTRR
	eend $?
	if [[ $? -ne 0 ]] ; then
	ewarn "You don't have MTRR support enabled, the direct rendering"
	ewarn "will not work."
	fi

	ebegin "Checking for AGP support enabled"
	linux_chkconfig_present AGP
	eend $?
	if [[ $? -ne 0 ]] ; then
	ewarn "You don't have AGP support enabled, the direct rendering"
	ewarn "will not work."
	fi
	ebegin "Checking for DRM support disabled"
	! linux_chkconfig_present DRM
	eend $?
	if [[ $? -ne 0 ]] ; then
	ewarn "You have DRM support enabled, the direct rendering"
	ewarn "will not work."
	fi

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

#	if kernel_is 2 6
#	then
#	fi

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
			make -C ${KV_DIR} M="`pwd`" GCC_VER_MAJ=$(gcc-major-version) \
				modules || ewarn "DRM module not built"
		else
			make -C ${KV_DIR} SUBDIRS="`pwd`" GCC_VER_MAJ=$(gcc-major-version) \
				modules || ewarn "DRM module not built"
		fi
		set_arch_to_portage
	else
		export _POSIX2_VERSION="199209"
		# That is the dirty way to avoid the id -u check
		sed -e 's:`id -u`:0:' \
			-e "s:\`uname -r\`:${KV_FULL}:" \
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

	# Install the libs
	# MULTILIB-CLEANUP: Fix this when FEATURES=multilib-pkg is in portage
	local MLTEST=$(type dyn_unpack)
	if [ "${MLTEST/set_abi}" = "${MLTEST}" ] && has_multilib_profile; then
		local OABI=${ABI}
		for ABI in $(get_install_abis); do
			src_install-libs
		done
		ABI=${OABI}
		unset OABI
	elif has_multilib_profile; then
		src_install-libs
	elif use amd64; then
		src_install-libs lib $(get_multilibdir)
		src_install-libs lib64 $(get_libdir)
	else
		src_install-libs
	fi &> /dev/null

	#apps
	insinto /etc/env.d
	doins ${FILESDIR}/09ati
	exeinto /opt/ati/bin
	doexe usr/X11R6/bin/*

	#ati custom stuff
	insinto /usr
	doins -r ${WORKDIR}/usr/include
}

src_install-libs() {
	local pkglibdir=lib
	local inslibdir=$(get_libdir)

	if [ ${#} -eq 2 ]; then
		pkglibdir=${1}
		inslibdir=${2}
	elif has_multilib_profile && [ "${ABI}" == "amd64" ]; then
		pkglibdir=lib64
	fi

	einfo "${pkglibdir} -> ${inslibdir}"

	local ATI_ROOT="/usr/${inslibdir}/opengl/ati"

	# The GLX libraries
	exeinto ${ATI_ROOT}/lib
	doexe ${WORKDIR}/usr/X11R6/${pkglibdir}/libGL.so.1.2
	dosym libGL.so.1.2 ${ATI_ROOT}/lib/libGL.so.1
	dosym libGL.so.1.2 ${ATI_ROOT}/lib/libGL.so

	# Don't do this... see bug #47598
	#dosym libGL.so.1.2 ${ATI_ROOT}/lib/libMesaGL.so

	# same as the xorg implementation
	dosym ../${X11_IMPLEM}/extensions ${ATI_ROOT}/extensions
	#Workaround
	if use opengl ; then
	sed -e "s:libdir=.*:libdir=${ATI_ROOT}/lib:" \
		/usr/${inslibdir}/opengl/${X11_IMPLEM}/lib/libGL.la \
		> $D/${ATI_ROOT}/lib/libGL.la
	dosym ../${X11_IMPLEM}/include ${ATI_ROOT}/include
	fi
	# X and DRI driver
	if has_version ">=x11-base/xorg-x11-6.8.0-r4"
	then
		local X11_DIR="/usr/"
	else
		local X11_DIR="/usr/X11R6/"
	fi

	local X11_LIB_DIR="${X11_DIR}${inslibdir}"

	exeinto ${X11_LIB_DIR}/modules/drivers
	doexe ${WORKDIR}/usr/X11R6/${pkglibdir}/modules/drivers/fglrx_drv.o

	exeinto ${X11_LIB_DIR}/modules/dri
	doexe ${WORKDIR}/usr/X11R6/${pkglibdir}/modules/dri/fglrx_dri.so
	doexe ${WORKDIR}/usr/X11R6/${pkglibdir}/modules/dri/atiogl_a_dri.so

	exeinto ${X11_LIB_DIR}/modules/linux
	doexe ${WORKDIR}/usr/X11R6/${pkglibdir}/modules/linux/libfglrxdrm.a
	cp -a ${WORKDIR}/usr/X11R6/${pkglibdir}/libfglrx_gamma.* \
			${D}/${X11_LIB_DIR}
	#Not the best place
	insinto ${X11_DIR}/include/X11/extensions
	doins ${WORKDIR}/usr/X11R6/include/X11/extensions/fglrx_gamma.h

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
	if use !opengl ; then
	ewarn "You don't have the opengl useflag enabled, you won't be able to build"
	ewarn "opengl applications nor use opengl driver features, if that isn't"
	ewarn "the intended behaviour please add opengl to your useflag and issue"
	ewarn "# emerge -Nu ati-drivers"
	fi
	# DRM module
	update-modules
}

pkg_postrm() {
	opengl-update --use-old xorg-x11
}

