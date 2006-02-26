# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kxdocker/kxdocker-1.0.0a.ebuild,v 1.1 2006/02/26 06:35:40 dragonheart Exp $

inherit kde

DESCRIPTION="KXDocker is the KDE animated docker, supports plugins and notifications"
HOMEPAGE="http://www.xiaprojects.com/www/prodotti/kxdocker/main.php"
SRC_URI="http://www.xiaprojects.com/www/downloads/files/kxdocker/1.0.0/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=kde-misc/kxdocker-resources-1.0.0"

#	i18n? ( >=kde-misc/kxdocker-i18n-1.0.2 )"

DEPEND="${RDEPEND}
	arts? ( ~kde-base/arts )"

# List of needed plugins
#kde-misc/kxdocker-arpmanager-1.0.0
#kde-misc/kxdocker-configurator-1.0.0
#kde-misc/kxdocker-dcop-1.0.0
#kde-misc/kxdocker-gipcontrack-1.0.0
#kde-misc/kxdocker-gmount-1.0.0
#kde-misc/kxdocker-gnetio-1.0.0
#kde-misc/kxdocker-gpipe-1.0.0
#kde-misc/kxdocker-mountmanager-1.0.0
#kde-misc/kxdocker-networker-1.0.0
#kde-misc/kxdocker-taskmanager-1.0.0
#kde-misc/kxdocker-thememanager-1.0.0
#kde-misc/kxdocker-trayiconlogger-1.0.0
#kde-misc/kxdocker-wizard-1.0.0"

need-kde 3.2


src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-parallelmake.patch
}
pkg_postinst() {
	ewarn "To complete your kxdocker installation you need to emerge these plugins."
	ewarn "kde-misc/kxdocker-arpmanager bug #123991"
	ewarn "kde-misc/kxdocker-configurator bug #123992"
	ewarn "kde-misc/kxdocker-dcop bug #123994"
	ewarn "kde-misc/kxdocker-gipcontrack bug #123996"
	ewarn "kde-misc/kxdocker-gmount bug #123997"
	ewarn "kde-misc/kxdocker-gnetio bug #123998"
	ewarn "kde-misc/kxdocker-gpipe bug #124001"
#	ewarn "kde-misc/kxdocker-i18n bug #124002"
	ewarn "kde-misc/kxdocker-mountmanager bug #124003"
	ewarn "kde-misc/kxdocker-networker bug #124004"
	ewarn "kde-misc/kxdocker-taskmanager bug #124006"
	ewarn "kde-misc/kxdocker-thememanager bug #124007"
	ewarn "kde-misc/kxdocker-trayiconlogger bug #124008"
	ewarn "kde-misc/kxdocker-wizard bug #124009"
	ewarn ""
	ebeep 5
	epause 3
}
