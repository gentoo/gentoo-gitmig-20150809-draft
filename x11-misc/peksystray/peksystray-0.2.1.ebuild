# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/peksystray/peksystray-0.2.1.ebuild,v 1.6 2005/08/07 13:39:51 hansmi Exp $

inherit eutils

DESCRIPTION="A system tray dockapp for window managers supporting docking"
HOMEPAGE="http://freshmeat.net/projects/peksystray"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ppc x86"
DEPEND="virtual/x11"
IUSE=""

src_compile() {
	econf --x-libraries=/usr/X11R6/lib || die
	emake || die
}

src_install() {
	dobin src/peksystray

	dodoc AUTHORS NEWS README THANKS TODO
}
