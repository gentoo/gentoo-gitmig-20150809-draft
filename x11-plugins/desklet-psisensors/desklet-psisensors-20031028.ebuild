# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-psisensors/desklet-psisensors-20031028.ebuild,v 1.2 2004/04/05 03:24:57 agriffis Exp $

MY_PN="PsiSensorPackage"
MY_P=${MY_PN}-${PV}
S=${WORKDIR}

DESCRIPTION="Psi's collection of popular gDesklet Sensors including CPU, Disk, Memory, Network and other Sensors"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}.tar.bz2"
HOMEPAGE="http://gdesklets.gnomedesktop.org/"
LICENSE="as-is"

SLOT="0"
IUSE=""
KEYWORDS="~x86 ~ppc ~alpha"

DEPEND=">=gnome-extra/gdesklets-core-0.23
	!x11-plugins/desklet-cpuinfo
	!x11-plugins/desklet-diskinfo
	!x11-plugins/desklet-meminfo
	!x11-plugins/desklet-networkinfo"
# This package provides all of the *info desklets,
# which are now outdated. We need to block them, or 
# we could have two packages providing the same file.

DOCS="README ChangeLog"

src_install() {

	SYS_PATH="/usr/share/gdesklets"
	dodir ${SYS_PATH}/Sensors

	# We dont want to include the FontSelector sensor
	# here, as it's provided with the core library now
	rm -rf ${S}/{FontSelector,MemoOver}-*
	# We're also removing the MemoOver sensor as it's not
	# complete, requires per-user python script to store
	# memos etc.

	for sensor in $( ls ); do

		cd ${S}/${sensor}
		INSTALL_BIN="Install_${sensor/-*/}_Sensor.bin"
		python ${INSTALL_BIN} --nomsg ${D}${SYS_PATH}/Sensors

		docinto ${sensor}
		dodoc ${DOCS}

	done

	# the desklets unpack preserves permissions of the archive
	chown -R root:root ${D}${SYS_PATH}/Sensors

}

