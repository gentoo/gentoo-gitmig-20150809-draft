# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-multitail/desklet-multitail-0.2.2.ebuild,v 1.1 2004/02/04 13:40:49 obz Exp $

DESKLET_NAME="MultiTail"
S=${WORKDIR}/${DESKLET_NAME}-${PV}

DESCRIPTION="A desklet that allows the 'tail' or viewing of multiple files on your desktop"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${PN/desklet-/}-${PV}.tar.bz2"
HOMEPAGE="http://gdesklets.gnomedesktop.org/"
LICENSE="as-is"

SLOT="0"
IUSE=""
KEYWORDS="~x86"

DEPEND=">=gnome-extra/gdesklets-core-0.25"

DOCS="README"

src_install() {

	# set up our paths 
	SYS_PATH="/usr/share/gdesklets"
	INSTALL_BIN="Install_${DESKLET_NAME}_Sensor.bin"
	dodir ${SYS_PATH}/{Sensors,Displays}

	# first we install the Sensors
	python ${INSTALL_BIN} --nomsg ${D}${SYS_PATH}/Sensors

# and now the display
	cp -R ${DESKLET_NAME} ${D}${SYS_PATH}/Displays
	rm ${D}${SYS_PATH}/Displays/${DESKLET_NAME}/README

	dodoc ${DESKLET_NAME}/${DOCS}

}

