# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-external/desklet-external-0.21.ebuild,v 1.1 2003/09/10 11:52:09 obz Exp $

DESKLET_NAME="External"

MY_PN=${PN/desklet-/}-sensor
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="An external Sensor for gdesklets for capruting other programs output"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}.tar.bz2"
HOMEPAGE="http://www.pycage.de/"
LICENSE="as-is"

SLOT="0"
IUSE=""
KEYWORDS="~x86"

DEPEND=">=gnome-extra/gdesklets-core-0.20"

DOCS="INSTALL README examples/tail.display examples/desktop_cow.display"

src_install( ) {

	SYS_PATH="/usr/share/gdesklets"
	INSTALL_BIN="Install_${DESKLET_NAME}_Sensor.bin"
	dodir ${SYS_PATH}/Sensors

	# first we install the Sensor
	python ${INSTALL_BIN} --nomsg ${D}${SYS_PATH}/Sensors

	dodoc ${DOCS}

}

