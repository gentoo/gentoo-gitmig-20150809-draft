# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/curl/curl-7.12.3.ebuild,v 1.2 2005/06/23 01:40:45 agriffis Exp $

# NOTE: If you bump this ebuild, make sure you bump dev-python/pycurl!

inherit eutils

DESCRIPTION="A Client that groks URLs"
HOMEPAGE="http://curl.haxx.se/"
SRC_URI="http://curl.haxx.se/download/${P}.tar.bz2"

LICENSE="MIT X11"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ppc64 ~s390"
IUSE="ssl ipv6 ldap"

DEPEND="ssl? ( >=dev-libs/openssl-0.9.6a )
	ldap? ( net-nds/openldap )"

RESTRICT="test"

src_compile() {
	econf \
		`use_enable ipv6` \
		`use_enable ldap` \
		`use_with ssl` \
		--enable-http \
		--enable-ftp \
		--enable-gopher \
		--enable-file \
		--enable-dict \
		--enable-manual \
		--enable-telnet \
		--enable-nonblocking \
		--enable-largefile \
		|| die
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc LEGAL CHANGES README
	dodoc docs/FEATURES docs/INSTALL docs/INTERNALS docs/LIBCURL
	dodoc docs/MANUAL docs/FAQ docs/BUGS docs/CONTRIBUTE

}
