# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/curl/curl-7.10.5.ebuild,v 1.1 2003/06/12 23:15:31 liquidx Exp $

DESCRIPTION="A Client that groks URLs"
SRC_URI="http://curl.haxx.se/download/${P}.tar.bz2"
HOMEPAGE="http://curl.haxx.se/"

SLOT="0"
LICENSE="MIT X11"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE="ssl ipv6 ldap"

DEPEND=">=sys-libs/pam-0.75 
	ssl? ( >=dev-libs/openssl-0.9.6a )"

src_compile() {
	local myconf="--with-gnu-ld --enable-http --enable-ftp --enable-gopher --enable-file \
			--enable-dict --enable-telnet --enable-nonblocking"
	use ipv6	&& myconf="${myconf} --enable-ipv6"
	use ldap	&& myconf="${myconf} --enable-ldap"
	use ssl		&& myconf="${myconf} --with-ssl"

	econf ${myconf}
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc LEGAL CHANGES README 
	dodoc docs/FEATURES docs/INSTALL docs/INTERNALS docs/LIBCURL 
	dodoc docs/MANUAL docs/FAQ docs/BUGS docs/CONTRIBUTE
}
