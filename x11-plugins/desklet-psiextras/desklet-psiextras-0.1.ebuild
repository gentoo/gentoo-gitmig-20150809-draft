# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-psiextras/desklet-psiextras-0.1.ebuild,v 1.2 2004/07/19 09:50:46 dholm Exp $

DESKLET_NAME="desklet-psiextras"

S=${WORKDIR}

DESCRIPTION="The Psi-themed GoodWeather, battery, launcher, pager, weather and wireless displays for gDesklets"
SRC_URI="http://gdesklets.gnomedesktop.org/files/GoodWeather-psi.tar.bz2
	http://gdesklets.gnomedesktop.org/files/psi-battery-0.1.tar.bz2
	http://gdesklets.gnomedesktop.org/files/psi-launcher1.0.tgz
	http://gdesklets.gnomedesktop.org/files/psi-pager.tar.gz
	http://gdesklets.gnomedesktop.org/files/psi-weather.tar.bz2
	http://gdesklets.gnomedesktop.org/files/psi-wireless-0.1.tar.bz2"
HOMEPAGE="http://gdesklets.gnomedesktop.org/"
LICENSE="as-is"

SLOT="0"
IUSE=""
KEYWORDS="~x86 ~ppc"

DEPEND=">=gnome-extra/gdesklets-core-0.26
	>=x11-plugins/desklet-psidisplays-20040420
	>=x11-plugins/desklet-goodweather-0.4
	>=x11-plugins/desklet-wireless-0.2
	>=x11-plugins/desklet-battery-0.2"

src_install() {

	SYS_PATH="/usr/share/gdesklets"
	INSTALL_BIN="Install_${DESKLET_NAME}_Sensor.bin"
	dodir ${SYS_PATH}/{Sensors,Displays}
	dodir ${SYS_PATH}/Displays/${DESKLET_NAME}

	# first we install the Sensors
	for i in `find . -iname "Install_*"`; do
		python ${i} --nomsg ${D}${SYS_PATH}/Sensors
	done

	# and then the .displays
	for j in `find . -iname "*.display"`; do
		dodir ${SYS_PATH}/Displays/${DESKLET_NAME}/`dirname ${j}`
		insinto ${SYS_PATH}/Displays/${DESKLET_NAME}/`dirname ${j}`/
		doins ${j}
	done

	# and finally the graphics
	for k in `find . -iname "gfx"`; do
		cp -R ${k} ${D}${SYS_PATH}/Displays/${DESKLET_NAME}/`dirname ${k}`/
	done

	# and here we need to fix up any of the desklets
	# that don't install otherwise
	cd ${S}/psi-battery-0.1/
	cp *.png ${D}${SYS_PATH}/Displays/${DESKLET_NAME}/psi-battery-0.1/

	# the desklets unpack preserves permissions of the archive
	chown -R root:root ${D}${SYS_PATH}/Sensors/

}

