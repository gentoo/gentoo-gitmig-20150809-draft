# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/jdiskreport-bin/jdiskreport-bin-1.2.2.ebuild,v 1.1 2005/08/13 05:13:40 compnerd Exp $

MY_PN=${PN/-bin/}
MY_PV=${PV//\./_}

DESCRIPTION="JDiskReport helps you to understand disk drive usage"
HOMEPAGE="http://www.jgoodies.com/freeware/jdiskreport/index.html"
SRC_URI="http://www.jgoodies.com/download/${MY_PN}/${MY_PN}-${MY_PV}.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}/${MY_PN}-${PV}

src_compile() {
	einfo "Binary only package"

	# We hate, we hate, versioned JARs
	mv ${MY_PN}-${PV}.jar ${MY_PN}.jar
}

src_install() {
	local INSTROOT=${ROOT}opt/${MY_PN}

	# Create a Launcher Script
	cat > ${MY_PN} <<- EOF
		#!/bin/sh
		\$(java-config -J) -jar $INSTROOT/bin/${MY_PN}.jar
	EOF

	# Install the launcher script
	dobin ${MY_PN}

	insinto ${INSTROOT}/bin
	doins ${MY_PN}.jar

	dodoc README.txt RELEASE-NOTES.txt
}
