# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bblaunch/bblaunch-0.0.3.ebuild,v 1.11 2007/08/02 13:48:29 uberlord Exp $

inherit eutils

IUSE=""
DESCRIPTION="An application launcher for Blackbox type window managers"
SRC_URI="http://www.stud.ifi.uio.no/~steingrd/${P}.tar.gz"
HOMEPAGE="http://blackboxwm.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86 ~x86-fbsd"

DEPEND="virtual/blackbox"

src_compile () {
	epatch ${FILESDIR}/${P}.patch
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc README CHANGELOG AUTHORS
}
