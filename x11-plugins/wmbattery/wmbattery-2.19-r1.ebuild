# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmbattery/wmbattery-2.19-r1.ebuild,v 1.6 2006/01/24 22:18:27 nelchael Exp $

inherit eutils

IUSE=""

S=${WORKDIR}/${PN}

DESCRIPTION="A dockable app to report APM battery stats."
SRC_URI="http://kitenet.net/programs/wmbattery/${P/-/_}.tar.gz"
HOMEPAGE="http://kitenet.net/programs/wmbattery"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 -sparc ~ppc"

RDEPEND="sys-apps/apmd
	|| ( (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXt
		x11-libs/libXpm )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( x11-proto/xextproto virtual/x11 )"

src_compile() {
	econf || die "Configuration failed"
	emake icondir="/usr/share/pixmaps/wmbattery" || die "Compilation failed"
}

src_install () {
	dobin wmbattery
	dodoc README TODO

	mv wmbattery.1x wmbattery.1
	doman wmbattery.1

	insinto /usr/share/pixmaps/wmbattery
	doins *.xpm
}
