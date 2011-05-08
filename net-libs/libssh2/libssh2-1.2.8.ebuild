# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libssh2/libssh2-1.2.8.ebuild,v 1.1 2011/05/08 20:18:13 jer Exp $

EAPI="2"

inherit autotools-utils

DESCRIPTION="Library implementing the SSH2 protocol"
HOMEPAGE="http://www.libssh2.org/"
SRC_URI="http://www.${PN}.org/download/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x64-macos ~x86-solaris"
IUSE="gcrypt static-libs zlib"

DEPEND="!gcrypt? ( dev-libs/openssl )
	gcrypt? ( dev-libs/libgcrypt )
	zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}"

src_configure() {
	local myconf

	if use gcrypt; then
		myconf="--with-libgcrypt"
	else
		myconf="--with-openssl"
	fi

	econf \
		$(use_with zlib libz) \
		$(use_enable static-libs static) \
		${myconf}
}

src_test() {
	if [[ ${EUID} -ne 0 ]]; then #286741
		ewarn "Some tests require real user that is allowed to login."
		ewarn "ssh2.sh test disabled."
		sed -e 's:ssh2.sh::' -i tests/Makefile
	fi
	emake check || die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README
	use static-libs || remove_libtool_files
}
