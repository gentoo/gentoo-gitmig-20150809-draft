# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/sel/sel-0.08.2.ebuild,v 1.14 2004/07/15 00:06:59 agriffis Exp $

DESCRIPTION="A filemanager for shell scripts"
SRC_URI="http://www.rhein-neckar.de/~darkstar/files/${P}.tar.gz"
HOMEPAGE="http://www.rhein-neckar.de/~darkstar/sel.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc s390"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.1"

src_unpack () {
	unpack ${A}
	cd ${S}

	cp Makefile Makefile.orig
	sed -e "s:-m486:${CFLAGS}:" -e "s:-O3::" Makefile.orig > Makefile

	cp sel.c sel.c.orig
	sed -e "s:/usr/local/share/sel/help\.txt:/usr/share/sel/help\.txt:" \
		sel.c.orig > sel.c
}

src_compile() {
	make || die
}

src_install () {
	dobin sel
	doman sel.1
	insinto /usr/share/sel
	doins help.txt
	dodoc Changelog LICENSE
}
