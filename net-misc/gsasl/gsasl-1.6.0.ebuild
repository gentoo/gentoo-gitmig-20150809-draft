# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gsasl/gsasl-1.6.0.ebuild,v 1.4 2011/06/24 15:20:30 armin76 Exp $

EAPI="2"

inherit autotools-utils

DESCRIPTION="The GNU SASL client, server, and library"
HOMEPAGE="http://www.gnu.org/software/gsasl/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="doc gcrypt idn kerberos nls static-libs"

# TODO: check http://www.gnu.org/software/gsasl/#dependencies for more
# 	optional external libraries.
DEPEND="
	gcrypt? ( dev-libs/libgcrypt )
	idn? ( net-dns/libidn )
	kerberos? ( virtual/krb5 )
	nls? ( sys-devel/gettext )
"
RDEPEND="${DEPEND}"

src_configure() {
	econf \
		--enable-client \
		--enable-server \
		--disable-valgrind-tests \
		$(use_enable kerberos gssapi) \
		$(use_with gcrypt libgcrypt) \
		$(use_enable nls) \
		$(use_with idn stringprep) \
		$(use_enable static-libs static)
}

src_install() {
	make DESTDIR="${D}" install || die "einstall failed"
	use static-libs || remove_libtool_files
	dodoc AUTHORS ChangeLog NEWS README THANKS
	doman doc/gsasl.1

	if use doc; then
		dodoc doc/*.{eps,ps,pdf}
		dohtml doc/*.html
		docinto examples
		dodoc examples/*.c
	fi
}
