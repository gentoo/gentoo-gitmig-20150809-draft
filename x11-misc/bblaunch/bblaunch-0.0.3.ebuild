# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bblaunch/bblaunch-0.0.3.ebuild,v 1.8 2004/06/24 22:12:54 agriffis Exp $

IUSE=""
DESCRIPTION="An application launcher for Blackbox type window managers"
SRC_URI="http://www.stud.ifi.uio.no/~steingrd/${P}.tar.gz"
HOMEPAGE="http://blackboxwm.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="virtual/blackbox"

src_compile () {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc README CHANGELOG AUTHORS
}
