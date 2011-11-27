# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libssh2/libssh2-1.3.0.ebuild,v 1.6 2011/11/27 04:27:56 radhermit Exp $

EAPI="4"

inherit autotools-utils

DESCRIPTION="Library implementing the SSH2 protocol"
HOMEPAGE="http://www.libssh2.org/"
SRC_URI="http://www.${PN}.org/download/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~x64-macos ~x86-solaris"
IUSE="gcrypt static-libs test zlib"

DEPEND="!gcrypt? ( dev-libs/openssl )
	gcrypt? ( dev-libs/libgcrypt )
	zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}"

AUTOTOOLS_IN_SOURCE_BUILD=1

src_configure() {
	local myconf

	if use gcrypt; then
		myconf="--with-libgcrypt"
	else
		myconf="--with-openssl"
	fi

	# Disable tests that require extra permissions (bug #333319)
	use test && export ac_cv_path_SSHD=

	econf \
		$(use_with zlib libz) \
		$(use_enable static-libs static) \
		${myconf}
}

src_install() {
	default
	dodoc README
	use static-libs || remove_libtool_files
}
