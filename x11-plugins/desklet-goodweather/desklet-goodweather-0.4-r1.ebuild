# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-goodweather/desklet-goodweather-0.4-r1.ebuild,v 1.1 2004/12/02 05:00:58 obz Exp $

DESKLET_NAME="GoodWeather"

MY_P=${DESKLET_NAME}-${PV}
S=${WORKDIR}/${DESKLET_NAME}

DESCRIPTION="A desklet producing weather forecasts for the coming week"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}.tar.bz2"
HOMEPAGE="http://gdesklets.gnomedesktop.org/categories.php?func=gd_show_app&gd_app_id=93"
LICENSE="as-is"

SLOT="0"
IUSE=""
KEYWORDS="~x86 ~ppc ~amd64 ~alpha"

DEPEND=">=gnome-extra/gdesklets-core-0.26"

DOCS="README"

src_unpack() {

	unpack ${A}
	cd ${S}
	# fix the "metha/meta" typo for gdesklets-0.3x
	sed -i -e "s:metha:meta:" GoodWeather.display

}

src_install() {

	SYS_PATH="/usr/share/gdesklets"
	INSTALL_BIN="Install_${DESKLET_NAME}_Sensor.bin"
	dodir ${SYS_PATH}/{Sensors,Displays}

	# first we install the Sensor
	python ${INSTALL_BIN} --nomsg ${D}${SYS_PATH}/Sensors

	# and then the .displays
	insinto ${SYS_PATH}/Displays/${DESKLET_NAME}
	doins *.display

	# and finally the graphics
	cp -R gfx/ ${D}${SYS_PATH}/Displays/${DESKLET_NAME}

	dodoc ${DOCS}

	# the desklets unpack preserves permissions of the archive
	chown -R root:root ${D}${SYS_PATH}/Sensors/${DESKLET_NAME}

}

