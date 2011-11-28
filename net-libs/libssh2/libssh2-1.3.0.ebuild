# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libssh2/libssh2-1.3.0.ebuild,v 1.7 2011/11/28 02:35:04 radhermit Exp $

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

DOCS=( README )

src_configure() {
	local myeconfargs

	if use gcrypt; then
		myeconfargs+=" --with-libgcrypt"
	else
		myeconfargs+=" --with-openssl"
	fi

	# Disable tests that require extra permissions (bug #333319)
	use test && export ac_cv_path_SSHD=

	myeconfargs+=(
		$(use_with zlib libz)
	)
	autotools-utils_src_configure
}
