# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/peksystray/peksystray-0.2.ebuild,v 1.5 2004/06/24 22:30:26 agriffis Exp $

inherit eutils

DESCRIPTION="A system tray dockapp for window managers supporting docking"
HOMEPAGE="http://freshmeat.net/projects/peksystray"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 alpha"
DEPEND="virtual/x11"
IUSE=""

src_unpack() {
	unpack ${A}

	# Quick patch to get rid of the multi-line string literal.
	# 	-taviso (10 Jan 2004)
	cd ${S}; epatch ${FILESDIR}/${PN}-gcc3-mlsl.diff
}

src_install() {
	dodoc AUTHORS COPYING NEWS README THANKS TODO
	dobin src/peksystray
}
