# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-starterbar/desklet-starterbar-0.31.ebuild,v 1.1 2004/12/02 05:13:36 obz Exp $

DESKLET_NAME="StarterBar"

MY_PN=${PN/desklet-/}-desklet
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="An OSX like gnome panel for launchers"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}.tar.gz"
HOMEPAGE="http://gdesklets.gnomedesktop.org/categories.php?func=gd_show_app&gd_app_id=13"
LICENSE="as-is"

SLOT="0"
IUSE=""
KEYWORDS="~x86 ~ppc ~amd64"

DEPEND=">=gnome-extra/gdesklets-core-0.31.1
	>=dev-python/pyxdg-0.5"

DOCS="README"

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

