# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/dvorak7min/dvorak7min-1.6.1.ebuild,v 1.3 2003/11/12 14:19:18 vapier Exp $

DESCRIPTION="simple ncurses-based typing tutor for learning the Dvorak keyboard layout"
HOMEPAGE="http://www.linalco.com/comunidad.html"
SRC_URI="http://www.linalco.com/ragnar/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

DEPEND=""

src_compile() {
	make clean
	emake || die "Make failed"
}

src_install() {
	dobin dvorak7min
	dodoc ChangeLog README
}
