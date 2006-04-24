# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kxdocker-configurator/kxdocker-configurator-1.0.2.ebuild,v 1.2 2006/04/24 11:15:03 dragonheart Exp $

inherit kde

DESCRIPTION="KXDocker configurator plugin for KXDocker (the KDE animated docker)"
HOMEPAGE="http://www.xiaprojects.com/www/prodotti/kxdocker/main.php"
SRC_URI="http://www.xiaprojects.com/www/downloads/files/kxdocker/1.0.0/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=kde-misc/kxdocker-1.1.3a"

need-kde 3.2

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch ${FILESDIR}/${P}-collisions.patch
}

