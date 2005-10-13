# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/corewars/corewars-0.9.13-r1.ebuild,v 1.6 2005/10/13 20:32:35 mr_bones_ Exp $

inherit games

DESCRIPTION="Simulation game involving virtual machine code"
HOMEPAGE="http://corewars.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ppc x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/x11
	>=dev-libs/glib-1.2.10-r1
	=x11-libs/gtk+-1.2*"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog README doc/{TODO,DIFFERENCES,INTERESTING-COMBINATIONS}
	prepgamesdirs
}
