# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-rssgrab/desklet-rssgrab-0.6.2.ebuild,v 1.8 2007/07/11 20:39:22 mr_bones_ Exp $

DESKLET_NAME="rssgrab"

MY_PN=${PN/desklet-/}
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A news/rss grabbing display for gDesklets"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}.tar.gz"
HOMEPAGE="http://gdesklets.gnomedesktop.org/categories.php?func=gd_show_app&gd_app_id=101"
LICENSE="as-is"

SLOT="0"
IUSE=""
KEYWORDS="~amd64 ia64 ppc ~x86"

DEPEND=">=gnome-extra/gdesklets-core-0.26"

DOCS="INSTALL README README.feeds"

src_install() {

	SYS_PATH="/usr/share/gdesklets"
	INSTALL_BIN="Install_${DESKLET_NAME}_Sensor.bin"
	dodir ${SYS_PATH}/{Sensors,Displays}

	# first we install the Sensor
	python ${INSTALL_BIN} --nomsg ${D}${SYS_PATH}/Sensors

	# and then the .displays
	insinto ${SYS_PATH}/Displays/${DESKLET_NAME}
	doins LTrssgrab.display rssgrab-orig.display rssgrab-psi.display

	# and finally the graphics
	cp -R gfx/ ${D}${SYS_PATH}/Displays/${DESKLET_NAME}

	dodoc ${DOCS}

	# the desklets unpack preserves permissions of the archive
	chown -R root:0 ${D}${SYS_PATH}/Sensors/${DESKLET_NAME}

}
