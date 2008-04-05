# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/tunapie/tunapie-2.1.5.ebuild,v 1.1 2008/04/05 17:39:01 drac Exp $

inherit eutils

DESCRIPTION="Directory browser for Radio and TV streams"
HOMEPAGE="http://tunapie.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="offensive"

RDEPEND="=dev-python/wxpython-2.6*"
DEPEND=""

src_unpack() {
	unpack ${A}
	sed -i -e 's:/usr/local:/usr:' "${S}"/${PN}
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
	dodoc CHANGELOG README

	domenu ${PN}.desktop
	doicon src/tplogo.xpm

	insinto /usr/share/${PN}
	doins src/{*.py,*.png}

	dodir /etc

	if use offensive; then
		echo 1 > "${D}"/etc/${PN}.config
	else
		echo 0 > "${D}"/etc/${PN}.config
	fi
}
