# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/curl/curl-7.10.7.ebuild,v 1.3 2003/12/13 00:17:10 gmsoft Exp $

DESCRIPTION="A Client that groks URLs"
SRC_URI="http://curl.haxx.se/download/${P}.tar.bz2"
HOMEPAGE="http://curl.haxx.se/"

SLOT="0"
LICENSE="MIT X11"
KEYWORDS="x86 ~ppc ~sparc ~alpha hppa ~amd64"
IUSE="ssl ipv6 ldap"

DEPEND="ssl? ( >=dev-libs/openssl-0.9.6a )
	ldap? ( net-nds/openldap )"

src_compile() {
	local myconf="--with-gnu-ld	--enable-http
		--enable-ftp --enable-gopher
		--enable-file --enable-dict
		--enable-telnet --enable-nonblocking"

	econf ${myconf} \
		`use_enable ipv6` \
		`use_enable ldap` \
		`use_with ssl` || die

	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc LEGAL CHANGES README
	dodoc docs/FEATURES docs/INSTALL docs/INTERNALS docs/LIBCURL
	dodoc docs/MANUAL docs/FAQ docs/BUGS docs/CONTRIBUTE
}
