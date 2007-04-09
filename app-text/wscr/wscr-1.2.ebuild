# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wscr/wscr-1.2.ebuild,v 1.13 2007/04/09 15:29:24 welp Exp $

DESCRIPTION="A Lightweight and Fast Anagram Solver"
HOMEPAGE="http://hood.sjfn.nb.ca/~eddie/wscr.html"
SRC_URI="ftp://hood.sjfn.nb.ca/pub/eddie/${P}.tar.gz"
LICENSE="public-domain"
SLOT="0"

KEYWORDS="alpha ~amd64 mips ppc sparc x86"
IUSE=""
DEPEND="virtual/libc"
RDEPEND="virtual/libc sys-apps/miscfiles"

src_compile() {
	sed -i 's#"/usr/dict/words";#"/usr/share/dict/words";#' wscr.h
	sed -i 's#\($(CC) $(FLAGS)\)#\1 ${CFLAGS}#g' Makefile
	emake || die
}

src_install() {
	dobin wscr
	doman wscr.6
	dodoc README
}
