# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/corewars/corewars-0.9.13-r1.ebuild,v 1.4 2004/06/24 23:22:13 agriffis Exp $

inherit games

DESCRIPTION="Simulation game involving virtual machine code"
HOMEPAGE="http://corewars.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

KEYWORDS="x86 ppc ~amd64"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/x11
	virtual/glibc
	>=dev-libs/glib-1.2.10-r1
	=x11-libs/gtk+-1.2*"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog README doc/{TODO,DIFFERENCES,INTERESTING-COMBINATIONS}
	prepgamesdirs
}
