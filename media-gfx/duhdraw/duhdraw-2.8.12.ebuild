# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/duhdraw/duhdraw-2.8.12.ebuild,v 1.2 2003/07/12 16:44:48 aliz Exp $

DESCRIPTION="ASCII art editor"
HOMEPAGE="http://www.wwco.com/~wls/opensource/duhdraw.php"
SRC_URI="http://www.wwco.com/~wls/opensource/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="sys-libs/ncurses"
S=${WORKDIR}/${P}

src_compile() {
	emake CC="${CC} -s ${CFLAGS}" || die
}

src_install() {
	dobin ansi ansitoc duhdraw
	dodoc CREDITS HISTORY TODO READ.ME
}
