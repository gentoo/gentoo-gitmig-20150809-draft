# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-base/gnustep-make/gnustep-make-1.10.1_pre20041030.ebuild,v 1.3 2004/11/12 03:46:56 fafhrd Exp $

ECVS_CVS_COMMAND="cvs -q"
ECVS_SERVER="savannah.gnu.org:/cvsroot/gnustep"
ECVS_USER="anoncvs"
ECVS_AUTH="ext"
ECVS_MODULE="gnustep/core/make"
ECVS_CO_OPTS="-P -D ${PV/*_pre}"
ECVS_UP_OPTS="-dP -D ${PV/*_pre}"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/savannah.gnu.org-gnustep"
inherit gnustep cvs

S=${WORKDIR}/${ECVS_MODULE}

DESCRIPTION="The makefile package is a simple, powerful and extensible way to write makefiles for a GNUstep-based project."
HOMEPAGE="http://www.gnustep.org"

KEYWORDS="~x86 ~ppc ~amd64 ~sparc ~alpha"
SLOT="0"
LICENSE="GPL-2"

IUSE="${IUSE} doc"
DEPEND="${GNUSTEP_CORE_DEPEND}
	>=sys-devel/make-3.75
	${DOC_DEPEND}"
RDEPEND="${DEPEND}
	${DOC_RDEPEND}"

pkg_setup() {
	gnustep_pkg_setup

	# okay, I couldn't figure out how to check if a dependency was
	#  compiled with a specific use flag, so we do it ./configure
	#  check-for-lib style ...
	gcc ${FILESDIR}/helloworld.m -o $TMP/helloworld -lobjc || die \
		"gcc must be compiled with Objective-C support! See the objc USE flag."
}

src_unpack() {
	cvs_src_unpack
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/make-user-defaults.patch-1.10.0
}

src_compile() {
	cd ${S}

	myconf="--prefix=${GENTOO_GNUSTEP_ROOT}"
	myconf="$myconf --with-network-root=${GENTOO_GNUSTEP_ROOT}/Network"
	myconf="$myconf --with-tar=/bin/tar"
	econf $myconf || die "configure failed"

	egnustep_make
}

src_install() {
	. ${S}/GNUstep.sh

	if [ -f ./[mM]akefile -o -f ./GNUmakefile ] ; then
		if use debug ; then
			emake -j1 INSTALL_ROOT=${D} \
				GNUSTEP_SYSTEM_ROOT=${D}${GNUSTEP_SYSTEM_ROOT} \
				GNUSTEP_NETWORK_ROOT=${D}${GNUSTEP_NETWORK_ROOT} \
				GNUSTEP_LOCAL_ROOT=${D}${GNUSTEP_LOCAL_ROOT} \
				debug=yes install || die "install has failed"
		else
			emake -j1 INSTALL_ROOT=${D} \
				GNUSTEP_SYSTEM_ROOT=${D}${GNUSTEP_SYSTEM_ROOT} \
				GNUSTEP_NETWORK_ROOT=${D}${GNUSTEP_NETWORK_ROOT} \
				GNUSTEP_LOCAL_ROOT=${D}${GNUSTEP_LOCAL_ROOT} \
				install || die "install has failed"
		fi
	else
		die "no Makefile found"
	fi

	. ${D}${GENTOO_GNUSTEP_ROOT}/System/Library/Makefiles/GNUstep.sh

	if use doc ; then
		cd Documentation
		make INSTALL_ROOT=${D} \
			GNUSTEP_SYSTEM_ROOT=${D}${GNUSTEP_SYSTEM_ROOT} \
			GNUSTEP_MAKEFILES=${D}${GENTOO_GNUSTEP_ROOT}/System/Library/Makefiles \
			GNUSTEP_USER_ROOT=${TMP}/GNUstep \
			GNUSTEP_DEFAULTS_ROOT=${TMP}/GNUstep \
			all || die "doc build failed"
		make INSTALL_ROOT=${D} \
			GNUSTEP_SYSTEM_ROOT=${D}${GNUSTEP_SYSTEM_ROOT} \
			GNUSTEP_MAKEFILES=${D}${GENTOO_GNUSTEP_ROOT}/System/Library/Makefiles \
			GNUSTEP_USER_ROOT=${TMP}/GNUstep \
			GNUSTEP_DEFAULTS_ROOT=${TMP}/GNUstep \
			install || die "doc install failed"
		cd ..
	fi
}

