# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmwave/wmwave-0.4.ebuild,v 1.5 2004/08/01 23:27:42 s4t4n Exp $

IUSE=""
S="${WORKDIR}/wmwave"
KEYWORDS="~ppc x86"
DESCRIPTION="wmwave is a dockapp that displays quality, link, level and noise of an iee802.11 (wavelan) connection."
SRC_URI="mirror://sourceforge/wmwave/${PN}-0-4.tgz"
HOMEPAGE="http://wmwave.sourceforge.net/"
LICENSE="GPL-2"
DEPEND="virtual/x11"
SLOT="0"

src_compile() {
	emake FLAGS="${CFLAGS}" || die "Compilation failed"
}

src_install () {
	dobin wmwave
	doman wmwave.1
	dodoc COPYING README
}
