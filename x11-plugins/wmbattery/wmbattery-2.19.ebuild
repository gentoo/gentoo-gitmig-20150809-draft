# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmbattery/wmbattery-2.19.ebuild,v 1.5 2004/06/24 23:05:13 agriffis Exp $

IUSE=""

S=${WORKDIR}/${PN}

DESCRIPTION="A dockable app to report APM battery stats."
SRC_URI="http://kitenet.net/programs/wmbattery/${P/-/_}.tar.gz"
HOMEPAGE="http://kitenet.net/programs/wmbattery"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 amd64"

DEPEND="virtual/x11
	sys-apps/apmd"

src_install () {
	dobin wmbattery
	doman wmbattery.1x
	dodoc README COPYING TODO

	insinto /usr/share/pixmaps/wmbattery
	doins *.xpm
}
