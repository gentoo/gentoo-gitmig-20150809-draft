# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-sysinfo/desklet-sysinfo-0.25.ebuild,v 1.5 2004/09/02 18:22:39 pvdabeel Exp $

DESKLET_NAME="SysInfo"

MY_P=${DESKLET_NAME}-${PV}
S=${WORKDIR}/${DESKLET_NAME}

DESCRIPTION="A system information providing Display/Sensor for gDesklets"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}.tar.bz2"
HOMEPAGE="http://gdesklets.gnomedesktop.org/categories.php?func=gd_show_app&gd_app_id=56"
LICENSE="as-is"

SLOT="0"
IUSE=""
KEYWORDS="~x86 ppc ~amd64"

DEPEND=">=gnome-extra/gdesklets-core-0.24"

DOCS="ChangeLog"

src_install() {

	SYS_PATH="/usr/share/gdesklets"
	INSTALL_BIN="Install_${DESKLET_NAME}_Sensor.bin"
	dodir ${SYS_PATH}/{Sensors,Displays}

	cd ${WORKDIR}
	# first we install the Sensor
	python ${INSTALL_BIN} --nomsg ${D}${SYS_PATH}/Sensors

	cd ${S}
	# and then the .displays
	insinto ${SYS_PATH}/Displays/${DESKLET_NAME}
	doins *.display

	# and finally the graphics
	cp -R gfx/ ${D}${SYS_PATH}/Displays/${DESKLET_NAME}
	# remove extraneous CVS dir
	rm -rf ${D}${SYS_PATH}/Displays/${DESKLET_NAME}/gfx/CVS

	dodoc ${DOCS}

	# desklets unpack preserves the permissions of the archive
	chown -R root:root ${D}${SYS_PATH}/Sensors/${DESKLET_NAME}

}

