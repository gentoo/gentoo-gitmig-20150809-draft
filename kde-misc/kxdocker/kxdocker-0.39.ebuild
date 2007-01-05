# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kxdocker/kxdocker-0.39.ebuild,v 1.3 2007/01/05 17:04:06 flameeyes Exp $

inherit kde

DESCRIPTION="KXDocker is the KDE animated docker, supports plugins and notifications"
HOMEPAGE="http://www.xiaprojects.com/www/prodotti/kxdocker/main.php"
SRC_URI="http://www.xiaprojects.com/www/downloads/files/kxdocker/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=kde-misc/kxdocker-resources-0.14"

need-kde 3.2

src_install() {
	kde_src_install
	rm -rf ${D}/usr/share/doc/HTML
}

pkg_postinst() {
	elog "If you are upgrading for version older than 0.27 please use new default configuration."
	elog "since 0.28 has AutoSave enabled by default, please remember it will overwrite your HOME/.kde/share/apps/kxdocker/kxdocker_conf.xml"
}
