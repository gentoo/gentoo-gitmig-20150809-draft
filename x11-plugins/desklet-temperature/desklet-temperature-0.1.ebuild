# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-temperature/desklet-temperature-0.1.ebuild,v 1.6 2004/09/02 18:22:39 pvdabeel Exp $

DESKLET_NAME="TempNOAA"

MY_PN=${PN/desklet-/}
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A temperature desklet that displays the temperature as it changes over 24 hours"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}.tar.bz2"
HOMEPAGE="http://gdesklets.gnomedesktop.org/categories.php?func=gd_show_app&gd_app_id=60"
LICENSE="as-is"

SLOT="0"
IUSE=""
KEYWORDS="~x86 ppc"

DEPEND=">=gnome-extra/gdesklets-core-0.22"

DOCS="README"

src_install( ) {

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

}

