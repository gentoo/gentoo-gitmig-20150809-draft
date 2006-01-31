# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmwave/wmwave-0.4.ebuild,v 1.8 2006/01/31 21:06:41 nelchael Exp $

IUSE=""
S="${WORKDIR}/wmwave"
KEYWORDS="ppc x86"
DESCRIPTION="wmwave is a dockapp that displays quality, link, level and noise of an iee802.11 (wavelan) connection."
SRC_URI="mirror://sourceforge/wmwave/${PN}-0-4.tgz"
HOMEPAGE="http://wmwave.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXpm )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( x11-proto/xextproto virtual/x11 )"

src_compile() {
	emake FLAGS="${CFLAGS}" || die "Compilation failed"
}

src_install () {
	dobin wmwave
	doman wmwave.1
	dodoc README
}
