# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/gnustep.eclass,v 1.20 2004/10/22 03:24:24 fafhrd Exp $

inherit eutils flag-o-matic

ECLASS=gnustep
INHERITED="$INHERITED $ECLASS"

DESCRIPTION="EClass designed to facilitate building GNUstep Apps, Frameworks, and Bundles on Gentoo."

IUSE="debug"
DOC_DEPEND="doc? ( virtual/tetex
		=dev-tex/latex2html-2002*
		=app-text/texi2html-1.6* )"
GNUSTEP_CORE_DEPEND="virtual/libc
	>=sys-devel/gcc-3.0.4
	${DOC_DEPEND}"
GNUSTEP_BASE_DEPEND="${GNUSTEP_CORE_DEPEND}
	gnustep-base/gnustep-make
	gnustep-base/gnustep-base"
GNUSTEP_GUI_DEPEND="${GNUSTEP_BASE_DEPEND}
	gnustep-base/gnustep-gui"
GS_DEPEND="${GNUSTEP_GUI_DEPEND}"
DEBUG_DEPEND="debug? >=sys-devel/gdb-6.0"
DOC_RDEPEND="doc? ( sys-apps/man
	=sys-apps/texinfo-4.6* )"
GS_RDEPEND="${GS_DEPEND}
	${DEBUG_DEPEND}
	${DOC_RDEPEND}
	virtual/gnustep-back
	gnustep-base/gnustep-env"

GENTOO_GNUSTEP_ROOT="/usr/GNUstep"

egnustep_env() {
	if [ -f ${GENTOO_GNUSTEP_ROOT}/System/Makefiles/GNUstep.sh ] ; then
		. ${GENTOO_GNUSTEP_ROOT}/System/Makefiles/GNUstep.sh
	else
		die "gnustep-make not installed!"
	fi
}

egnustep_make() {
	if [ -f ./[mM]akefile -o -f ./GNUmakefile ] ; then
		if use debug ; then
			emake -j1 HOME=${TMP} \
				GNUSTEP_USER_ROOT=${TMP}/GNUstep \
				GNUSTEP_DEFAULTS_ROOT=${TMP}/GNUstep \
				INSTALL_ROOT_DIR=${D} \
				GNUSTEP_INSTALLATION_DIR=${D}${GNUSTEP_SYSTEM_ROOT} \
				GNUSTEP_MAKEFILES=${GNUSTEP_SYSTEM_ROOT}/Library/Makefiles \
				GNUSTEP_NETWORK_ROOT=${GNUSTEP_NETWORK_ROOT} \
				GNUSTEP_LOCAL_ROOT=${GNUSTEP_LOCAL_ROOT} \
				GNUSTEP_SYSTEM_ROOT=${GNUSTEP_SYSTEM_ROOT} \
				TAR_OPTIONS="${TAR_OPTIONS} --no-same-owner" \
				debug=yes all || die "package make failed"
		else
			emake -j1 HOME=${TMP} \
				GNUSTEP_USER_ROOT=${TMP}/GNUstep \
				GNUSTEP_DEFAULTS_ROOT=${TMP}/GNUstep \
				INSTALL_ROOT_DIR=${D} \
				GNUSTEP_INSTALLATION_DIR=${D}${GNUSTEP_SYSTEM_ROOT} \
				GNUSTEP_MAKEFILES=${GNUSTEP_SYSTEM_ROOT}/Library/Makefiles \
				GNUSTEP_NETWORK_ROOT=${GNUSTEP_NETWORK_ROOT} \
				GNUSTEP_LOCAL_ROOT=${GNUSTEP_LOCAL_ROOT} \
				GNUSTEP_SYSTEM_ROOT=${GNUSTEP_SYSTEM_ROOT} \
				TAR_OPTIONS="${TAR_OPTIONS} --no-same-owner" \
				all || die "package make failed"
		fi
	else
		die "no Makefile found"
	fi
	return 0
}

egnustep_package_config() {
	if [ -f ${FILESDIR}/config-${PN}.sh ]; then
		dodir ${GENTOO_GNUSTEP_ROOT}/System/Tools/Gentoo
		exeinto ${GENTOO_GNUSTEP_ROOT}/System/Tools/Gentoo
		doexe ${FILESDIR}/config-${PN}.sh
	fi
}

egnustep_package_config_info() {
	if [ -f ${FILESDIR}/config-${PN}.sh ]; then
		einfo "Make sure to set happy defaults for this package by executing:"
		einfo "  ${GENTOO_GNUSTEP_ROOT}/System/Tools/Gentoo/config-${PN}.sh"
		einfo "as the user you will run the package as." 
	fi
}

egnustep_install() {
	if [ -f ./[mM]akefile -o -f ./GNUmakefile ] ; then
		if use debug ; then
			emake -j1 HOME=${TMP} \
				GNUSTEP_USER_ROOT=${TMP}/GNUstep \
				GNUSTEP_DEFAULTS_ROOT=${TMP}/GNUstep \
				INSTALL_ROOT_DIR=${D} \
				GNUSTEP_INSTALLATION_DIR=${D}${GNUSTEP_SYSTEM_ROOT} \
				GNUSTEP_MAKEFILES=${GNUSTEP_SYSTEM_ROOT}/Library/Makefiles \
				GNUSTEP_NETWORK_ROOT=${GNUSTEP_NETWORK_ROOT} \
				GNUSTEP_LOCAL_ROOT=${GNUSTEP_LOCAL_ROOT} \
				GNUSTEP_SYSTEM_ROOT=${GNUSTEP_SYSTEM_ROOT} \
				TAR_OPTIONS="${TAR_OPTIONS} --no-same-owner" \
				debug=yes install || die "package install failed"
		else
			emake -j1 HOME=${TMP} \
				GNUSTEP_USER_ROOT=${TMP}/GNUstep \
				GNUSTEP_DEFAULTS_ROOT=${TMP}/GNUstep \
				INSTALL_ROOT_DIR=${D} \
				GNUSTEP_INSTALLATION_DIR=${D}${GNUSTEP_SYSTEM_ROOT} \
				GNUSTEP_MAKEFILES=${GNUSTEP_SYSTEM_ROOT}/Library/Makefiles \
				GNUSTEP_NETWORK_ROOT=${GNUSTEP_NETWORK_ROOT} \
				GNUSTEP_LOCAL_ROOT=${GNUSTEP_LOCAL_ROOT} \
				GNUSTEP_SYSTEM_ROOT=${GNUSTEP_SYSTEM_ROOT} \
				TAR_OPTIONS="${TAR_OPTIONS} --no-same-owner" \
				install || die "package install failed"
		fi
	else
		die "no Makefile found" 
	fi
	return 0
}

egnustep_doc() {
	if [ -f ./Documentation/GNUmakefile -o -f ./Documentation/[mM]akefile ]
	then
		cd Documentation
			make HOME=${TMP} \
				GNUSTEP_USER_ROOT=${TMP}/GNUstep \
				INSTALL_ROOT_DIR=${D} \
				GNUSTEP_INSTALLATION_DIR=${D}${GNUSTEP_SYSTEM_ROOT} \
				GNUSTEP_SYSTEM_ROOT=${GNUSTEP_SYSTEM_ROOT} \
				all || die "doc make failed"
			make HOME=${TMP} \
				GNUSTEP_USER_ROOT=${TMP}/GNUstep \
				GNUSTEP_DEFAULTS_ROOT=${TMP}/GNUstep \
				INSTALL_ROOT_DIR=${D} \
				GNUSTEP_INSTALLATION_DIR=${D}${GNUSTEP_SYSTEM_ROOT} \
				GNUSTEP_MAKEFILES=${GNUSTEP_SYSTEM_ROOT}/Library/Makefiles \
				GNUSTEP_SYSTEM_ROOT=${GNUSTEP_SYSTEM_ROOT} \
				TAR_OPTIONS="${TAR_OPTIONS} --no-same-owner" \
				install || die "doc install failed"
		cd ..
	fi
}

gnustep_pkg_setup() {
	if test_version_info 3.3
	then
		#einfo "Using gcc 3.3*"
		# gcc 3.3 doesn't support certain 3.4.1 options,
		#  as well as having less specific -march options
		replace-flags -march=pentium-m -march=pentium3
		filter-flags -march=k8
    	filter-flags -march=athlon64
	    filter-flags -march=opteron
		
		strip-unsupported-flags
	elif test_version_info 3.4
	then
		# strict-aliasing is known to break obj-c stuff in gcc-3.4*
		filter-flags -fstrict-aliasing
	fi
}

gnustep_src_unpack() {
	unpack ${A}
	cd ${S}
}

gnustep_src_compile() {
	egnustep_env
	egnustep_make || die
}

gnustep_src_install() {
	egnustep_env
	egnustep_install || die
	if use doc ; then
		egnustep_env
		egnustep_doc || die
	fi
	egnustep_package_config
}

gnustep_pkg_postinst() {
	egnustep_package_config_info
}

EXPORT_FUNCTIONS pkg_setup src_unpack src_compile src_install pkg_postinst
