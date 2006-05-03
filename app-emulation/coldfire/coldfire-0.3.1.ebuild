# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/coldfire/coldfire-0.3.1.ebuild,v 1.1 2006/05/03 03:26:05 vapier Exp $

DESCRIPTION="Motorola Coldfire Emulator"
HOMEPAGE="http://www.slicer.ca/coldfire/"
SRC_URI="http://www.slicer.ca/coldfire/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="sys-libs/ncurses
	sys-libs/readline"

src_compile() {
	econf || die
	emake -j1 || die
}

src_install() {
	dodir /usr/bin
	einstall || die
	dodoc AUTHORS HACKING README
}
