# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kxdocker/kxdocker-0.37.ebuild,v 1.1 2005/10/01 01:26:29 dragonheart Exp $

inherit kde

DESCRIPTION="KXDocker is the KDE animated docker, supports plugins and notifications"
HOMEPAGE="http://www.xiaprojects.com/www/prodotti/kxdocker/main.php"
SRC_URI="http://www.xiaprojects.com/www/downloads/files/kxdocker/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=kde-misc/kxdocker-resources-0.13"

need-kde 3.2

src_install() {
	kde_src_install
	rm -rf ${D}/usr/share/doc/HTML
}
