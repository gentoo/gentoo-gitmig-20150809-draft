# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cgilib/cgilib-0.5.ebuild,v 1.13 2005/08/23 16:04:29 ka0ttic Exp $

DESCRIPTION="A programmers library for the CGI interface"
HOMEPAGE="http://www.infodrom.org/projects/cgilib/"
SRC_URI="http://www.infodrom.org/projects/${PN}/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~arm hppa ia64 ~mips ppc ~s390 sparc x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s|^\(CFLAGS = -I. -Wall\).*$|\1 ${CFLAGS}|" Makefile || \
		die "sed Makefile failed"
}

src_install() {
	insinto /usr/include
	doins cgi.h
	dolib.a libcgi.a
	doman *.[35]
	dodoc CHANGES CREDITS readme cookies.txt
}
