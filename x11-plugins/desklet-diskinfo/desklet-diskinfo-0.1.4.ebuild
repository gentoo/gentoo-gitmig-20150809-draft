# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-diskinfo/desklet-diskinfo-0.1.4.ebuild,v 1.1 2003/09/10 12:05:47 obz Exp $

SENS_NAME="Disk"
DISP_NAME="diskinfo"

SENS_P=${SENS_NAME}-${PV}
DISP_P=${DISP_NAME}-${PV}

DESCRIPTION="A CPU Monitor Sensor for gdesklets"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${SENS_P}.tar.bz2 \
		 http://gdesklets.gnomedesktop.org/files/${DISP_P}.tar.bz2"
HOMEPAGE="http://www.pycage.de/"
LICENSE="as-is"

SLOT="0"
IUSE=""
KEYWORDS="~x86"

DEPEND=">=gnome-extra/gdesklets-core-0.20
	>=x11-plugins/desklet-fontselector-0.1.5"

# unfortunately, these are usually dependent on the particular
# desklet and it's packager
DOCS="README ChangeLog"

SENS_S=${WORKDIR}/${SENS_P}
DISP_S=${WORKDIR}

src_install( ) {

	# set up our paths 
	SYS_PATH="/usr/share/gdesklets"
	INSTALL_BIN="Install_${SENS_NAME}_Sensor.bin"
	dodir ${SYS_PATH}/{Sensors,Displays}

	# first we install the Sensor
	cd ${SENS_S}
	python ${INSTALL_BIN} --nomsg ${D}${SYS_PATH}/Sensors
	# and the docs
	dodoc ${DOCS}

	# and now the display
	cd ${DISP_S}
	dodir ${SYS_PATH}/Displays/${DISP_NAME}/{dark,light}-theme
	# this one include both 'light' and 'dark' themed displays
	cp -R dark-theme/{${DISP_NAME}.display,gfx/} \
		${D}${SYS_PATH}/Displays/${DISP_NAME}/dark-theme
	cp -R light-theme/{${DISP_NAME}.display,gfx/} \
		${D}${SYS_PATH}/Displays/${DISP_NAME}/light-theme

}

