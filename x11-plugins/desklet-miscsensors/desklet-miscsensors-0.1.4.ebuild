# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-miscsensors/desklet-miscsensors-0.1.4.ebuild,v 1.1 2003/10/09 16:01:51 obz Exp $

DESKLET_NAMES="IconButton ExternalInterval"

S=${WORKDIR}

DESCRIPTION="A collection of miscellaneous Sensors only for gDesklets"
SRC_URI="http://gdesklets.gnomedesktop.org/files/IconButton-${PV}.tar.bz2
	http://gdesklets.gnomedesktop.org/files/ExternalInterval-${PV}.tar.bz2"
HOMEPAGE="http://www.pycage.de/"
LICENSE="as-is"

SLOT="0"
IUSE=""
KEYWORDS="~x86"

DEPEND=">=gnome-extra/gdesklets-core-0.22"

DOCS="README"

src_install( ) {

	for SENS in ${DESKLET_NAMES}; do

		cd ${S}/${SENS}-${PV}
		SYS_PATH="/usr/share/gdesklets"
		INSTALL_BIN="Install_${SENS}_Sensor.bin"
		dodir ${SYS_PATH}/Sensors

		# install the sensor
		python ${INSTALL_BIN} --nomsg ${D}${SYS_PATH}/Sensors

		# and do the docs
		docinto ${SENS}
		dodoc ${DOCS}

	done

}

