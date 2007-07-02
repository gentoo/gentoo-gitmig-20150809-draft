# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/bwmon/bwmon-1.3.ebuild,v 1.17 2007/07/02 14:36:59 peper Exp $

DESCRIPTION="Simple ncurses bandwidth monitor"
HOMEPAGE="http://bwmon.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="mirror"

DEPEND="sys-libs/ncurses"

SLOT="0"
LICENSE="GPL-2 public-domain"
KEYWORDS="amd64 hppa ~ppc sparc x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s:/usr/local/bin:\$\{DESTDIR\}usr/bin:" \
	    Makefile
	sed -i -e "s:CFLAGS =:CFLAGS = ${CFLAGS}:" \
	    -e "s:LDFLAGS =:LDFLAGS = -L/lib:" \
	    src/Makefile
}

src_compile() {
	emake || die
}

src_install () {
	dodir /usr/bin
	make DESTDIR=${D} install || die
	dodoc README
}
