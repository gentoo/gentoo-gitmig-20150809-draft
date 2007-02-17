# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/dircproxy/dircproxy-1.0.5.ebuild,v 1.15 2007/02/17 15:25:43 armin76 Exp $

inherit eutils

DESCRIPTION="an IRC proxy server"
HOMEPAGE="http://dircproxy.securiweb.net/"
SRC_URI="http://dircproxy.securiweb.net/pub/1.0/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ppc x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}/dircproxy-gcc4.patch"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog FAQ NEWS PROTOCOL README* INSTALL
}
