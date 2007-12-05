# Copyright 1999-2007 Gentoo Foundationq
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/xxv-skins/xxv-skins-1.0.1.ebuild,v 1.1 2007/12/05 20:35:24 hd_brummy Exp $

inherit eutils

DESCRIPTION="Additional skins for XXV"
HOMEPAGE="http://xxv.berlios.de/content/view/38/1/"
SRC_URI="http://download.berlios.de/xxv/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=net-www/xxv-${PV}
		!x11-themes/xxv-xstyle"

#S=${WORKDIR}
SKINROOT=/usr/share/xxv/skins

src_compile() {
:
}

src_install() {

	insinto ${SKINROOT}

	cd "${S}"
	cp -a * "${D}${SKINROOT}"
}
