# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-ltvariations/desklet-ltvariations-0.21-r1.ebuild,v 1.6 2004/09/02 18:22:39 pvdabeel Exp $

DESKLET_NAME="LTVariations"

MY_P=${DESKLET_NAME}-${PV}
S=${WORKDIR}

DESCRIPTION="The clock sensors and displays for gdesklets"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}.tgz"
HOMEPAGE="http://gdesklets.gnomedesktop.org/categories.php?func=gd_show_app&gd_app_id=46"
LICENSE="as-is"

SLOT="0"
IUSE=""
KEYWORDS="~x86 ppc amd64"

DEPEND=">=gnome-extra/gdesklets-core-0.22
	>=x11-plugins/desklet-weather-0.21"

src_install() {

	SYS_PATH="/usr/share/gdesklets"
	dodir ${SYS_PATH}/{Sensors,Displays}

	# the LTV Sensors
	cd ${S}/LTV\ Sensors/
	for i in `ls *.bin`; do
		python ${i} --nomsg ${D}${SYS_PATH}/Sensors
	done

	# and apparently we need the iconbutton sensor as well
	cd ${S}/Other\ Sensors/
	python Install_IconButton_Sensor.bin --nomsg ${D}/${SYS_PATH}/Sensors

	cd ${S}/LTCandy
	# and then the .displays
	insinto ${SYS_PATH}/Displays/${DESKLET_NAME}
	doins *.display

	# and finally the graphics, and their messed up permissions fix
	cp -R gfx/ ${D}${SYS_PATH}/Displays/${DESKLET_NAME}
	chmod 644 ${D}${SYS_PATH}/Displays/${DESKLET_NAME}/gfx/*.png

	# the desklets unpack preservers permissions of the archive
	chown -R root:root ${D}${SYS_PATH}/Sensors/

}

