# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/tunapie/tunapie-2.0_rc8.ebuild,v 1.1 2007/08/18 23:54:32 drac Exp $

inherit eutils

MY_P=${P/_rc/rc}

DESCRIPTION="Directory browser for Radio and TV streams"
HOMEPAGE="http://tunapie.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="offensive"

RDEPEND=">=dev-python/wxpython-2.6"
DEPEND="sys-apps/sed"

S="${WORKDIR}"/${MY_P}

src_install() {
	sed -i -e 's:/usr/local:/usr:' ${PN}
	dobin ${PN}
	doman ${PN}.1
	dodoc CHANGELOG README

	domenu ${PN}.desktop
	doicon src/tplogo.xpm

	insinto /usr/share/${PN}
	doins src/{*.py,*.png}

	dodir /etc

	if use offensive; then
		echo '1' > "${D}"/etc/${PN}.config
	else
		echo '0' > "${D}"/etc/${PN}.config
	fi
}
