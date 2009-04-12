# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/xxv-skins/xxv-skins-1.2.ebuild,v 1.3 2009/04/12 06:57:03 ulm Exp $

inherit eutils

DESCRIPTION="Additional skins for XXV"
HOMEPAGE="http://xxv.berlios.de/content/view/38/1/"
SRC_URI="mirror://berlios/xxv/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=www-misc/xxv-${PV}
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
