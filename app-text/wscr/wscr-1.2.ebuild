# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wscr/wscr-1.2.ebuild,v 1.15 2009/01/03 15:45:10 angelos Exp $

inherit toolchain-funcs

DESCRIPTION="A Lightweight and Fast Anagram Solver"
HOMEPAGE="http://hood.sjfn.nb.ca/~eddie/wscr.html"
SRC_URI="ftp://hood.sjfn.nb.ca/pub/eddie/${P}.tar.gz"
LICENSE="public-domain"
SLOT="0"

KEYWORDS="alpha amd64 mips ppc sparc x86"
IUSE=""
RDEPEND="sys-apps/miscfiles"

src_compile() {
	sed -i 's#"/usr/dict/words";#"/usr/share/dict/words";#' wscr.h
	emake CC="$(tc-getCC)" FLAGS="${CFLAGS}" || die
}

src_install() {
	dobin wscr || die "dobin failed"
	doman wscr.6
	dodoc README
}
