# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cgilib/cgilib-0.5.ebuild,v 1.1 2005/04/12 12:15:09 ka0ttic Exp $

DESCRIPTION="A programmers library for the CGI interface"
HOMEPAGE="http://www.infodrom.org/projects/cgilib/"
SRC_URI="http://www.infodrom.org/projects/${PN}/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_compile() {
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	insinto /usr/include
	doins cgi.h
	dolib.a libcgi.a
	doman *.[35]
	dodoc CHANGES CREDITS readme cookies.txt
}
