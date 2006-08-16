# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-base/gnustep-base/gnustep-base-1.12.0.ebuild,v 1.6 2006/08/16 00:55:42 weeve Exp $

inherit gnustep

DESCRIPTION="The GNUstep Base Library: general-purpose, non-gui Obj-C objects"

HOMEPAGE="http://www.gnustep.org"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/core/${P}.tar.gz"
KEYWORDS="~alpha ~amd64 ~ppc ppc-macos sparc ~x86"
SLOT="0"
LICENSE="GPL-2 LGPL-2.1"

# disable doc as it appears to be broken
IUSE="gcc-libffi"
DEPEND="${GNUSTEP_CORE_DEPEND}
	~gnustep-base/gnustep-make-1.12.0
	|| (
		dev-libs/ffcall
		gcc-libffi? ( >=sys-devel/gcc-3.3.5 )
	)
	>=dev-libs/libxml2-2.6
	>=dev-libs/libxslt-1.1
	>=dev-libs/gmp-4.1
	>=dev-libs/openssl-0.9.7
	>=sys-libs/zlib-1.2
	sys-apps/sed
	${DOC_DEPEND}"
RDEPEND="${DEPEND}
	${DEBUG_DEPEND}
	${DOC_RDEPEND}"

egnustep_install_domain "System"

pkg_setup() {
	# Order of preferences: ffcall, libffi from gcc
	if use gcc-libffi; then
		if [ "$(ffi_available)" == "no" ]; then
			ffi_not_available_info
			die "libffi is not available"
		fi
	fi
}

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${P}"-obey_homedir.patch
}

src_compile() {
	egnustep_env
	local myconf
	if ! use gcc-libffi; then
		einfo "Using ffcall for FFI, not libffi"
		myconf="--disable-libffi --enable-ffcall"
	else
		einfo "Using libffi for FFI, not ffcall"
		myconf="--enable-libffi --disable-ffcall"
		myconf="${myconf} --with-ffi-library=$(gcc-config -L) --with-ffi-include=$(gcc-config -L | sed 's/:.*//')/include"
	fi

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

#	if use doc ; then
#		local make_eval="\
#			special_prefix=\"\${D}\$(egnustep_system_root)\" \
#			makedir=\${D}\$(egnustep_system_root)/Library/Makefiles \
#			GNUSTEP_USER_ROOT=\${TMP} \
#			-j1"
#
#		if use debug ; then
#			make_eval="${make_eval} debug=yes"
#		fi
#		if use verbose ; then
#			make_eval="${make_eval} verbose=yes"
#		fi
#
#		cd ${S}/Documentation
#		eval make ${make_eval} all || die "doc make has failed"
#		eval make ${make_eval} install || die "doc install has failed"
#		cd ..
#	fi
	egnustep_package_config
}
