# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/duhdraw/duhdraw-2.8.13.ebuild,v 1.1 2006/11/16 09:01:44 jokey Exp $

inherit toolchain-funcs eutils

DESCRIPTION="ASCII art editor"
HOMEPAGE="http://www.cs.helsinki.fi/u/penberg/duhdraw"
SRC_URI="http://www.cs.helsinki.fi/u/penberg/duhdraw/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~ppc-macos ~x86"
IUSE=""

DEPEND="sys-libs/ncurses"
RDEPEND=${DEPEND}

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${P}"-macos.patch
	epatch "${FILESDIR}/${P}-2.8.12"-prestrip.patch
}

src_compile() {
	emake CC="$(tc-getCC) ${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin ansi ansitoc duhdraw || die
	dodoc CREDITS HISTORY TODO READ.ME
}
