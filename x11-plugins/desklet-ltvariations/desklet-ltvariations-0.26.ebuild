# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-ltvariations/desklet-ltvariations-0.26.ebuild,v 1.4 2005/08/26 20:47:20 nixphoeni Exp $

DESKLET_NAME="LTVariations"

MY_P=${DESKLET_NAME}-${PV}
S=${WORKDIR}

DESCRIPTION="The clock sensors and displays for gdesklets"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}.tar.gz"
HOMEPAGE="http://gdesklets.gnomedesktop.org/categories.php?func=gd_show_app&gd_app_id=46"
LICENSE="as-is"

SLOT="0"
IUSE=""
KEYWORDS="~x86 ppc ~amd64"

DEPEND="<=gnome-extra/gdesklets-core-0.33.1
	>=x11-plugins/desklet-weather-0.21"

src_install() {

	SYS_PATH="/usr/share/gdesklets"
	dodir ${SYS_PATH}/{Sensors,Displays}

	# the LTV Sensors
	cd ${S}/Sensors/
	for i in `ls *.bin`; do
		python ${i} --nomsg ${D}${SYS_PATH}/Sensors
	done

	cd ${S}/Displays/LTCandy
	# and then the .displays
	insinto ${SYS_PATH}/Displays/${DESKLET_NAME}
	doins *.display

	# and finally the graphics, and their messed up permissions fix
	cp -R gfx/ ${D}${SYS_PATH}/Displays/${DESKLET_NAME}
	chmod 644 ${D}${SYS_PATH}/Displays/${DESKLET_NAME}/gfx/*.png

	# the desklets unpack preservers permissions of the archive
	chown -R root:0 ${D}${SYS_PATH}/Sensors/

}

