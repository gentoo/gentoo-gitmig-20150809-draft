# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/ati-drivers/ati-drivers-8.19.10.ebuild,v 1.10 2006/02/22 09:57:27 lu_zero Exp $

IUSE="opengl"

inherit eutils rpm multilib linux-info linux-mod toolchain-funcs

DESCRIPTION="Ati precompiled drivers for r350, r300, r250 and r200 chipsets"
HOMEPAGE="http://www.ati.com"
SRC_URI="x86? ( mirror://gentoo/ati-driver-installer-${PV}-i386.run )
	 amd64? ( mirror://gentoo/ati-driver-installer-${PV}-x86_64.run )"

LICENSE="ATI"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=x11-base/xorg-x11-6.8.0
	 app-admin/eselect-opengl
	 || ( sys-libs/libstdc++-v3 =sys-devel/gcc-3.3* )"

DEPEND=">=virtual/linux-sources-2.4
	${RDEPEND}"

PROVIDE="virtual/opengl"

ATIBIN="${D}/opt/ati/bin"
RESTRICT="nostrip multilib-pkg-force"

MODULE_NAMES="fglrx(video:${WORKDIR}/common/lib/modules/fglrx/build_mod)"


choose_driver_folder() {
	#new modular X paths, 0 is a workaround.
	if [ "$(get_version_component_range 1 ${X11_IMPLEM_V})" = 7 ] \
		|| [ "$(get_version_component_range 1 ${X11_IMPLEM_V})" = 0 ]
	then
		BASE_NAME="${WORKDIR}/x690"
		xlibdir="xorg"
	else
		BASE_NAME="${WORKDIR}/x$(get_version_component_range 1 ${X11_IMPLEM_V})"
		xlibdir=""

		# Determine if we are facing X.org 6.8.99 aka 6.9
		if [ "$(get_version_component_range 1 ${X11_IMPLEM_V})" = 6 ] &&
		   [ "$(get_version_component_range 2 ${X11_IMPLEM_V})" = 8 ] &&
		   [ "$(get_version_component_range 3 ${X11_IMPLEM_V})" = 99 ]
		then
			BASE_NAME="${BASE_NAME}90"
		else
			BASE_NAME="${BASE_NAME}$(get_version_component_range 2 ${X11_IMPLEM_V})0"
		fi
	fi

	if use amd64 ; then
		BASE_NAME="${BASE_NAME}_64a"
	fi
}

pkg_setup(){
	#check kernel and sets up KV_OBJ
	linux-mod_pkg_setup
	local agp
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

		ebegin "Checking for PCI Express support enabled"
		linux_chkconfig_present PCIEPORTBUS
		eend $?

		if [[ $? -ne 0 ]] ; then
			ewarn "If you don't have either AGP or PCI Express support enabled, direct rendering"
			ewarn "could work only using the internal support."
		fi

	fi
	ebegin "Checking for DRM support disabled"
	! linux_chkconfig_builtin DRM
	eend $?
	if [[ $? -ne 0 ]] ; then
	ewarn "You have DRM support enabled builtin, the direct rendering"
	ewarn "will not work."
	fi

	# Set up X11 implementation
	X11_IMPLEM_P="$(best_version virtual/x11)"
	X11_IMPLEM="${X11_IMPLEM_P%-[0-9]*}"
	X11_IMPLEM="${X11_IMPLEM##*\/}"
	X11_IMPLEM_V="${X11_IMPLEM_P/${X11_IMPLEM}-/}"
	X11_IMPLEM_V="${X11_IMPLEM_V##*\/}"
	einfo "X11 implementation is ${X11_IMPLEM}."
	choose_driver_folder
}

src_unpack() {
	local OLDBIN="/usr/X11R6/bin"

	ebegin "Unpacking Ati drivers"
	sh ${DISTDIR}/${A} --extract ${WORKDIR} &> /dev/null
	eend $? || die "unpack failed"

	rm -rf ${BASE_NAME}/usr/X11R6/bin/{fgl_glxgears,fireglcontrolpanel}

	cd ${WORKDIR}/common/lib/modules/fglrx/build_mod

	if kernel_is ge 2 6 14
	then
		if use amd64
		then
		epatch ${FILESDIR}/fglrx-2.6.14-compat_ioctl.patch
		fi
	fi
}


src_compile() {
	einfo "Building the DRM module..."
	cd ${WORKDIR}/common/lib/modules/fglrx/build_mod
	ln -s ${BASE_NAME}/lib/modules/fglrx/build_mod/libfglrx_ip.a.GCC$(gcc-major-version)

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
		./make.sh || ewarn "DRM module not built"
	fi
}

pkg_preinst() {
	# Clean the dynamic libGL stuff's home to ensure
	# we don't have stale libs floating around ...
	if [ -d "${ROOT}/usr/lib/opengl/ati" ]
	then
		rm -rf ${ROOT}/usr/lib/opengl/ati/*
	fi
}

src_install() {
	local ATI_LIBGL_PATH=""
	cd ${WORKDIR}/common/lib/modules/fglrx/build_mod
	linux-mod_src_install

	cd ${WORKDIR}

	local native_dir
	use x86 && native_dir="lib"
	use amd64 && native_dir="lib64"

	# Install the libs
	# MULTILIB-CLEANUP: Fix this when FEATURES=multilib-pkg is in portage
	local MLTEST=$(type dyn_unpack)
	if [ "${MLTEST/set_abi/}" = "${MLTEST}" ] && has_multilib_profile; then
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
	exeinto /opt/ati/bin
	doexe ${BASE_NAME}/usr/X11R6/bin/*

	#ati custom stuff
	insinto /usr
	doins -r ${WORKDIR}/common/usr/include

	#env.d entry
	cp ${FILESDIR}/09ati ${T}/

	#Work around hardcoded path in 32bit libGL.so on amd64, bug 101539
	if has_multilib_profile && [ $(get_abi_LIBDIR x86) = "lib32" ] ; then
		ATI_LIBGL_PATH="/usr/lib32/modules/dri/:/usr/$(get_libdir)/modules/dri"
	fi
		cat >>${T}/09ati <<EOF

LIBGL_DRIVERS_PATH="$ATI_LIBGL_PATH"
EOF

	doenvd ${T}/09ati
}

src_install-libs() {
	local pkglibdir=lib
	local inslibdir="$(get_libdir)/${xlibdir}"
	ATI_LIBGL_PATH="${ATI_LIBGL_PATH}:/usr/$(get_libdir)/${xlibdir}/modules/dri"
	if [ ${#} -eq 2 ]; then
		pkglibdir=${1}
		inslibdir=${2}
	elif has_multilib_profile && [ "${ABI}" == "amd64" ]; then
		pkglibdir=lib64
	fi

	einfo "${pkglibdir} -> ${inslibdir}"

	local ATI_ROOT="/usr/$(get_libdir)/opengl/ati"

	# The GLX libraries
	exeinto ${ATI_ROOT}/lib
	doexe ${BASE_NAME}/usr/X11R6/${pkglibdir}/libGL.so.1.2
	dosym libGL.so.1.2 ${ATI_ROOT}/lib/libGL.so.1
	dosym libGL.so.1.2 ${ATI_ROOT}/lib/libGL.so

	# Don't do this... see bug #47598
	#dosym libGL.so.1.2 ${ATI_ROOT}/lib/libMesaGL.so

	# same as the xorg implementation
	dosym ../${X11_IMPLEM}/extensions ${ATI_ROOT}/extensions
	#Workaround
	if use opengl ; then
	sed -e "s:libdir=.*:libdir=${ATI_ROOT}/lib:" \
		/usr/$(get_libdir)/opengl/${X11_IMPLEM}/lib/libGL.la \
		> $D/${ATI_ROOT}/lib/libGL.la
	dosym ../${X11_IMPLEM}/include ${ATI_ROOT}/include
	fi
	# X and DRI driver
	if has_version "<x11-base/xorg-x11-6.8.0-r4"
	then
		local X11_DIR="/usr/X11R6/"
	else
		local X11_DIR="/usr/"
	fi

	local X11_LIB_DIR="${X11_DIR}${inslibdir}"

	exeinto ${X11_LIB_DIR}/modules/drivers
	# In X.org 6.8.99 / 6.9 this is a .so
	doexe ${BASE_NAME}/usr/X11R6/${pkglibdir}/modules/drivers/fglrx_drv.*o

	exeinto ${X11_LIB_DIR}/modules/dri
	doexe ${BASE_NAME}/usr/X11R6/${pkglibdir}/modules/dri/fglrx_dri.so
	doexe ${BASE_NAME}/usr/X11R6/${pkglibdir}/modules/dri/atiogl_a_dri.so

	exeinto ${X11_LIB_DIR}/modules/linux
	# In X.org 6.8.99 / 6.9 this is a .so
	if has_version ">=x11-base/xorg-x11-6.8.99"
	then
		doexe ${BASE_NAME}/usr/X11R6/${pkglibdir}/modules/linux/libfglrxdrm.so
	else
		doexe ${BASE_NAME}/usr/X11R6/${pkglibdir}/modules/linux/libfglrxdrm.a
	fi
	cp -pPR ${BASE_NAME}/usr/X11R6/${pkglibdir}/lib{fglrx_*,aticonfig} \
			${D}/${X11_LIB_DIR}
	#Not the best place
	insinto ${X11_DIR}/include/X11/extensions
	doins ${BASE_NAME}/usr/X11R6/include/X11/extensions/fglrx_gamma.h

	dodir /etc
	cp -pPR ${BASE_NAME}/etc/* ${D}/etc/
}


pkg_postinst() {
	/usr/bin/eselect opengl set --use-old ati

	echo
	einfo "To switch to ATI OpenGL, run \"eselect opengl set ati\""
	einfo "To change your xorg.conf you can use the bundled \"aticonfig\""
	if use !opengl ; then
	ewarn "You don't have the opengl useflag enabled, you won't be able to build"
	ewarn "opengl applications nor use opengl driver features, if that isn't"
	ewarn "the intended behaviour please add opengl to your useflag and issue"
	ewarn "# emerge -Nu ati-drivers"
	fi
	# DRM module
	linux-mod_pkg_postinst
}

pkg_postrm() {
	linux-mod_pkg_postrm
	/usr/bin/eselect opengl set --use-old xorg-x11
}
