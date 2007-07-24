# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/peksystray/peksystray-0.4.0.ebuild,v 1.1 2007/07/24 00:46:55 omp Exp $

DESCRIPTION="A system tray dockapp for window managers supporting docking"
HOMEPAGE="http://peksystray.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXt"
DEPEND="${RDEPEND}"

src_install() {
	dobin src/peksystray
	dodoc AUTHORS ChangeLog NEWS README REFS THANKS TODO
}
