# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/xxv-skins/xxv-skins-1.5.ebuild,v 1.2 2011/10/30 19:46:02 hd_brummy Exp $

inherit eutils

DESCRIPTION="Additional skins for XXV"
HOMEPAGE=""
SRC_URI="mirror://gentoo/${P}.tgz
		mirror://gentoo/xxv-jason-${PV}.tgz"

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
