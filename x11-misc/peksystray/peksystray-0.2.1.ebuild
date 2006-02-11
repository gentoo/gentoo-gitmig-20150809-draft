# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/peksystray/peksystray-0.2.1.ebuild,v 1.7 2006/02/11 11:22:28 nelchael Exp $

inherit eutils

DESCRIPTION="A system tray dockapp for window managers supporting docking"
HOMEPAGE="http://freshmeat.net/projects/peksystray"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ppc x86"
IUSE=""

RDEPEND="|| ( (
		x11-libs/libXt
		x11-libs/libX11 )
	virtual/x11 )"
DEPEND="${RDEPEND}"

src_compile() {
	econf --x-libraries=/usr/lib || die
	emake || die
}

src_install() {
	dobin src/peksystray
	dodoc AUTHORS NEWS README THANKS TODO
}
