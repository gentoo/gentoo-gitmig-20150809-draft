# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-base/gnustep-base/gnustep-base-1.10.2_pre20041116.ebuild,v 1.1 2004/11/16 23:14:09 fafhrd Exp $

ECVS_CVS_COMMAND="cvs -q"
ECVS_SERVER="savannah.gnu.org:/cvsroot/gnustep"
ECVS_USER="anoncvs"
ECVS_AUTH="ext"
ECVS_MODULE="gnustep/core/base"
ECVS_CO_OPTS="-P -D ${PV/*_pre}"
ECVS_UP_OPTS="-dP -D ${PV/*_pre}"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/savannah.gnu.org-gnustep"
inherit gnustep cvs

S=${WORKDIR}/${ECVS_MODULE}

DESCRIPTION="The GNUstep Base Library is a library of general-purpose, non-graphical Objective C objects."

HOMEPAGE="http://www.gnustep.org"
#SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/core/${P}.tar.gz"
KEYWORDS="~ppc ~x86 ~amd64 ~sparc ~alpha"
SLOT="0"
LICENSE="GPL-2 LGPL-2.1"

IUSE="${IUSE} doc"
DEPEND="${GNUSTEP_CORE_DEPEND}
	>=gnustep-base/gnustep-make-1.10.1_pre20041116
	>=dev-libs/libxml2-2.6*
	>=dev-libs/libxslt-1.1*
	>=dev-libs/gmp-4.1*
	>=dev-libs/openssl-0.9.7*
	>=dev-libs/libffi-3*
	>=sys-libs/zlib-1.2*
	${DOC_DEPEND}"
RDEPEND="${DEPEND}
	${DOC_RDEPEND}"

egnustep_install_domain "System"

src_unpack() {
	cvs_src_unpack ${A}
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/base-user-defaults.patch-1.10.0
}

src_compile() {
	egnustep_env
	# why libffi over ffcall?
	# - libffi is known to work with 32 and 64 bit platforms
	# - libffi does not use trampolines
	local myconf
	myconf="--enable-libffi --with-ffi-library=/usr/lib/libffi --with-ffi-include=/usr/include/libffi --disable-ffcall"
	myconf="$myconf --with-xml-prefix=/usr"
	myconf="$myconf --with-gmp-include=/usr/include --with-gmp-library=/usr/lib"
	econf $myconf || die "configure failed"

	egnustep_make || die
}

src_install() {
	egnustep_env
	egnustep_install || die

	local base_temp_lib_path
	if [ ! -z $GNUSTEP_FLATTENED ]; then
		base_temp_lib_path="$(egnustep_install_domain)/Library/Libraries"
	else
		base_temp_lib_path="$(egnustep_install_domain)/Library/Libraries/$GNUSTEP_HOST_CPU/$GNUSTEP_HOST_OS/$LIBRARY_COMBO"
	fi

	if use doc ; then
		local make_eval="INSTALL_ROOT=\${D} \
			GNUSTEP_SYSTEM_ROOT=\${D}\$(egnustep_system_root) \
			GNUSTEP_NETWORK_ROOT=\$(egnustep_network_root) \
			GNUSTEP_LOCAL_ROOT=\$(egnustep_local_root) \
			GNUSTEP_MAKEFILES=\$(egnustep_system_root)/Library/Makefiles \
			GNUSTEP_USER_ROOT=\${TMP} \
			GNUSTEP_DEFAULTS_ROOT=\${TMP}/\${__GS_USER_ROOT_POSTFIX} \
			LD_LIBRARY_PATH=\"\${D}\${base_temp_lib_path}:\${LD_LIBRARY_PATH}\" \
			GNUSTEP_INSTALLATION_DIR=\${D}\$(egnustep_install_domain) \
			-j1"
		if use debug ; then
			make_eval="${make_eval} debug=yes"
		fi
		if use verbose ; then
			make_eval="${make_eval} verbose=yes"
		fi

		cd ${S}/Documentation
		eval emake ${make_eval} all || die "doc make has failed"
		eval emake ${make_eval} install || die "doc install has failed"
		cd ..
	fi
	egnustep_package_config
}

