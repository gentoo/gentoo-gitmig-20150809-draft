# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kxdocker/kxdocker-1.1.4a.ebuild,v 1.2 2006/04/22 04:03:12 dragonheart Exp $

inherit kde

DESCRIPTION="KXDocker is the KDE animated docker, supports plugins and notifications"
HOMEPAGE="http://www.xiaprojects.com/www/prodotti/kxdocker/main.php"
SRC_URI="http://www.xiaprojects.com/www/downloads/files/kxdocker/1.0.0/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="nls net"

RDEPEND=">=kde-misc/kxdocker-resources-1.1.0
		nls? ( >=kde-misc/kxdocker-i18n-1.0.2 )"

#PDEPEND="bluetooth? ( >=kde-misc/kxdocker-bluetooth-1.0.0 )
#		net? ( >=kde-misc/kxdocker-networker-1.0.0
#		>=kde-misc/kxdocker-gnetio-1.0.0
#		>=kde-misc/kxdocker-gipcontrack-1.0.0
#		>=kde-misc/kxdocker-arpmanager-1.0.0
#		>=kde-misc/kxdocker-gpipe-1.0.0 )

PDEPEND="net? ( >=kde-misc/kxdocker-trayiconlogger-1.0.0-r1
			>=kde-misc/kxdocker-dcop-1.0.0-r1
			>=kde-misc/kxdocker-configurator-1.0.2 )"

# List of needed plugins (to run kxdocker)
#kde-misc/kxdocker-resources-1.1.0
#kde-misc/kxdocker-trayiconlogger-1.0.0-r1
#kde-misc/kxdocker-dcop-1.0.0-r1
#kde-misc/kxdocker-configurator-1.0.2
#
#
# List of optional/aviable plugins
#kde-misc/kxdocker-thememanager-1.0.0
#kde-misc/kxdocker-taskmanager-1.0.0
#kde-misc/kxdocker-mountmanager-1.0.0
#kde-misc/kxdocker-i18n-1.0.2
#kde-misc/kxdocker-wizard-1.0.0
#kde-misc/kxdocker-arpmanager-1.0.0
#kde-misc/kxdocker-gipcontrack-1.0.0
#kde-misc/kxdocker-gmount-1.0.0
#kde-misc/kxdocker-gnetio-1.0.0
#kde-misc/kxdocker-gpipe-1.0.0
#kde-misc/kxdocker-networker-1.0.0
#kde-misc/kxdocker-gamarok ~amd64
#kde-misc/kxdocker-gaclock ~amd64
#kde-misc/kxdocker-gapager ~amd64
#kde-misc/kxdocker-gbattery ~amd64
#kde-misc/kxdocker-gdate ~amd64
#kde-misc/kxdocker-gmail ~amd64
#kde-misc/kxdocker-bluetooth ~amd64
#kde-misc/kxdocker-gthrottle ~amd64
#kde-misc/kxdocker-gtrash ~amd64

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
