# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-base/gnustep-base/gnustep-base-1.10.1.ebuild,v 1.1 2004/10/31 05:39:52 fafhrd Exp $

inherit gnustep

DESCRIPTION="The GNUstep Base Library is a library of general-purpose, non-graphical Objective C objects."

HOMEPAGE="http://www.gnustep.org"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/core/${P}.tar.gz"
KEYWORDS="~ppc"
SLOT="0"
LICENSE="GPL-2 LGPL-2.1"

IUSE="${IUSE} doc"
DEPEND="${GNUSTEP_CORE_DEPEND}
	=gnustep-base/gnustep-make-1.10.1*
	>=dev-libs/libxml2-2.6*
	>=dev-libs/libxslt-1.1*
	>=dev-libs/gmp-4.1*
	>=dev-libs/openssl-0.9.7*
	>=dev-libs/libffi-3*
	>=sys-libs/zlib-1.2*
	${DOC_DEPEND}"
RDEPEND="${DEPEND}
	${DOC_RDEPEND}"

src_unpack() {
	unpack ${A}
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/base-user-defaults.patch-1.10.0
}

src_compile() {
	egnustep_env
	# why libffi over ffcall?
	# - libffi is known to work with 32 and 64 bit platforms
	# - libffi does not use trampolines
	myconf="--enable-libffi --with-ffi-library=/usr/lib/libffi --with-ffi-include=/usr/include/libffi --disable-ffcall"
	myconf="$myconf --with-xml-prefix=/usr"
	myconf="$myconf --with-gmp-include=/usr/include --with-gmp-library=/usr/lib"
	econf $myconf || die "configure failed"

	egnustep_make || die
}

src_install() {
	egnustep_env
	egnustep_install || die
	if use doc ; then
		cd ${S}/Documentation
		make HOME=${TMP} \
			GNUSTEP_USER_ROOT=${TMP}/GNUstep \
			INSTALL_ROOT_DIR=${D} \
			LD_LIBRARY_PATH="${D}${GNUSTEP_SYSTEM_ROOT}/Library/Libraries:${LD_LIBRARY_PATH}" \
			GNUSTEP_INSTALLATION_DIR=${D}${GNUSTEP_SYSTEM_ROOT} \
			GNUSTEP_SYSTEM_ROOT=${D}${GNUSTEP_SYSTEM_ROOT} \
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
	egnustep_package_config
}

