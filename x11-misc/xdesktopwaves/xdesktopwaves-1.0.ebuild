# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdesktopwaves/xdesktopwaves-1.0.ebuild,v 1.1 2004/11/19 12:54:27 dholm Exp $

DESCRIPTION="A cellular automata setting the background of your X Windows desktop under water"
HOMEPAGE="http://xdesktopwaves.sourceforge.net/"
LICENSE="GPL-2"
DEPEND="virtual/x11"

SLOT="0"
KEYWORDS="~ppc"
IUSE=""

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

src_compile() {
	emake || die
}

src_install() {
	dobin xdesktopwaves
	doman xdesktopwaves.1
	dodoc COPYING README
}
