# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kxdocker/kxdocker-1.1.4a.ebuild,v 1.4 2006/04/27 01:03:01 deathwing00 Exp $

inherit kde

DESCRIPTION="KXDocker is the KDE animated docker, supports plugins and notifications"
HOMEPAGE="http://www.xiaprojects.com/www/prodotti/kxdocker/main.php"
SRC_URI="http://www.xiaprojects.com/www/downloads/files/kxdocker/1.0.0/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="nls"

PDEPEND=">=kde-misc/kxdocker-resources-1.1.0
			>=kde-misc/kxdocker-trayiconlogger-1.0.0-r1
			>=kde-misc/kxdocker-dcop-1.0.0-r1
			>=kde-misc/kxdocker-configurator-1.0.2
			nls? ( >=kde-misc/kxdocker-i18n-1.0.2 )"

need-kde 3.2

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch ${FILESDIR}/${P}-parallelmake.patch
}

pkg_postinst() {
	einfo "Kxdocker installation is complete,"
	einfo "have a look in kde-misc/kxdocker-* for optional plugins."
	einfo ""
	einfo "If you are experience problems running Kxdocker"
	einfo "try to delete the old configuration file:"
	einfo " ~/.kde/share/apps/kxdocker/kxdocker_conf.xml"
	einfo "and launch Kxdocker again."
	einfo ""
}
