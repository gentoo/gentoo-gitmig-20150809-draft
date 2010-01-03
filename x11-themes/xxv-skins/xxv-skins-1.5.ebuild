# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/xxv-skins/xxv-skins-1.5.ebuild,v 1.1 2010/01/03 23:03:17 hd_brummy Exp $

inherit eutils

DESCRIPTION="Additional skins for XXV"
HOMEPAGE="http://xxv.berlios.de/content/view/45/1/"
SRC_URI="mirror://berlios/xxv/${P}.tgz
		mirror://berlios/xxv/xxv-jason-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="=www-misc/xxv-${PV}"

SKINROOT=/usr/share/xxv/skins

src_compile() {
:
}

src_install() {

	insinto ${SKINROOT}

	cd "${S}"
	cp -a * "${D}${SKINROOT}"

	cd "${WORKDIR}"
	cp -a jason "${D}${SKINROOT}"
}
