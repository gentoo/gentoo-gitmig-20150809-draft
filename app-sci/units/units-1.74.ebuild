# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/units/units-1.74.ebuild,v 1.11 2003/09/06 22:23:06 msterret Exp $

DESCRIPTION="program for units conversion and units calculation"
SRC_URI="ftp://ftp.gnu.org/gnu/units/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/units/units.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc alpha"

DEPEND=">=sys-libs/readline-4.1-r2
	>=sys-libs/ncurses-5.2-r3"

src_compile() {
	#Note: the trailing / is required in the datadir path.
	econf --datadir=/usr/share/${PN}/ || die
	emake || die
}

src_install() {
	einstall datadir=${D}/usr/share/${PN}/ || die
	dodoc ChangeLog NEWS README
}
