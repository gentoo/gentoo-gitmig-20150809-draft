# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmbattery/wmbattery-1.2.1-r2.ebuild,v 1.2 2004/11/01 20:39:41 gustavoz Exp $

inherit eutils

IUSE=""
S=${WORKDIR}/wmbattery
DESCRIPTION="A dockable app to report APM battery stats."
SRC_URI="http://kitenet.net/programs/code/wmbattery/wmbattery.tar.gz"
HOMEPAGE="http://kitenet.net/programs/wmbattery"

DEPEND="virtual/x11"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 -sparc"

src_compile() {
	econf || die "Configuration failed"
	emake icondir="/usr/share/pixmaps/wmbattery" || die "Compilation failed"
}

src_install () {
	dobin wmbattery
	dodoc README COPYING TODO

	mv wmbattery.1x wmbattery.1
	doman wmbattery.1

	#install the icons.
	insinto /usr/share/pixmaps/wmbattery
	doins *.xpm
}
