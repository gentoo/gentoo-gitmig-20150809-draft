# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-rhythmlet/desklet-rhythmlet-0.3g.ebuild,v 1.3 2004/07/20 19:48:07 kloeri Exp $

DESKLET_NAME="Rhythmlet"

MY_PN=${PN/desklet-/}
MY_P=${MY_PN}-${PV}-r2
S=${WORKDIR}/${MY_P}

DESCRIPTION="A display for controlling the Rhythmbox music player from gDesklets"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}.tar.gz"
HOMEPAGE="http://gdesklets.gnomedesktop.org/categories.php?func=gd_show_app&gd_app_id=162"
LICENSE="as-is"

SLOT="0"
IUSE=""
KEYWORDS="~x86 ~ppc"

DEPEND=">=gnome-extra/gdesklets-core-0.26
	>=x11-plugins/desklet-psisensors-20040420
	>=dev-python/gnome-python-2.0
	>=dev-python/soappy-0.11
	>=dev-python/imaging-1.0
	>=media-sound/rhythmbox-0.8.5"

DOCS="ChangeLog INSTALL README"

src_install() {

	SYS_PATH="/usr/share/gdesklets"
	INSTALL_BIN="Install_${DESKLET_NAME}_Sensor.bin"
	dodir ${SYS_PATH}/{Sensors,Displays}

	# first we install the Sensor
	python ${INSTALL_BIN} --nomsg ${D}${SYS_PATH}/Sensors

	# and then the .displays for the normal rhythmlet
	insinto ${SYS_PATH}/Displays/${DESKLET_NAME}
	doins *.display
	# and finally the graphics
	cp -R gfx/ ${D}${SYS_PATH}/Displays/${DESKLET_NAME}

	# and also the CornerRhythmlet .displays
	cd CornerRhythmlet
	insinto ${SYS_PATH}/Displays/${DESKLET_NAME}/CornerRhythmlet
	doins *.display
	cp -R gfx/ ${D}${SYS_PATH}/Displays/${DESKLET_NAME}/CornerRhythmlet

	cd ${S}
	# Install the documentation
	dodoc ${DOCS}

	# the desklets unpack preserves permissions of the archive
	chown -R root:root ${D}${SYS_PATH}/Sensors/${DESKLET_NAME}

}

