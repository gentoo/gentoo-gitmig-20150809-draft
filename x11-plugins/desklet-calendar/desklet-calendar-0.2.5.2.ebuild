# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-calendar/desklet-calendar-0.2.5.2.ebuild,v 1.4 2005/08/26 20:50:00 nixphoeni Exp $

DESKLET_NAME="Calendar"

MY_PN=${PN/desklet-/}
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="The calendar sensor and display for gDesklets"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}.tar.bz2"
HOMEPAGE="http://gdesklets.gnomedesktop.org/categories.php?func=gd_show_app&gd_app_id=68"
LICENSE="as-is"

SLOT="0"
IUSE=""
KEYWORDS="~x86 ppc"

DEPEND=">=gnome-extra/gdesklets-core-0.26
	>=x11-plugins/desklet-psisensors-20040420
	>=dev-python/pyxml-0.8"

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

	# the desklets unpack preserves permissions of the archive
	chown -R root:0 ${D}${SYS_PATH}/Sensors/${DESKLET_NAME}

}

