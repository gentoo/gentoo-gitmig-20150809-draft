# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/karamba-weather/karamba-weather-0.3.ebuild,v 1.3 2003/05/04 03:21:35 prez Exp $

DESCRIPTION="Weather plugin for Karamba"
HOMEPAGE="http://www.kdelook.org/content/show.php?content=5635"
SRC_URI="http://www.kdelook.org/content/files/5635-karamba_weather-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

RDEPEND="||( >=x11-misc/karamba-0.17 >=x11-misc/superkaramba-0.21 )"

src_unpack () {
	unpack ${A}
	mv karamba_weather ${P}
}

src_compile () {
	echo -n ""
}

src_install () {
	dodir /usr/share/karamba/bin /usr/share/karamba/themes
	cp k_weather.py ${D}/usr/share/karamba/bin
	chmod 755 ${D}/usr/share/karamba/bin/k_weather.py

	cp -r lcd ${D}/usr/share/karamba/themes/lcd_weather
	cp -r wind_icons ${D}/usr/share/karamba/themes/lcd_weather
	chmod -R go=u,go-w ${D}/usr/share/karamba/themes/lcd_weather

	cp -r plain ${D}/usr/share/karamba/themes/plain_weather
	cp -r wind_icons ${D}/usr/share/karamba/themes/plain_weather
	chmod -R go=u,go-w ${D}/usr/share/karamba/themes/plain_weather

	dodoc CHANGELOG README
}
