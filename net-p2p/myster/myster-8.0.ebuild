# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/myster/myster-8.0.ebuild,v 1.2 2004/06/29 09:18:03 squinky86 Exp $

inherit java-pkg

MY_PV=${PV/.0/}
DESCRIPTION="Myster is a decentralized file sharing network"
HOMEPAGE="http://www.mysternetworks.com/"
SRC_URI="mirror://sourceforge/myster/Myster_PR${MY_PV}_Generic.zip"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=virtual/jdk-1.4"
RDEPEND=">=virtual/jre-1.4"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	mv "Myster PR ${MY_PV} Generic" ${P}
	cd ${S}
}

src_compile () {
	echo "java -jar /opt/myster/Myster.jar" >> myster
	chmod -R go-w ${S}
	chmod +x myster
	einfo "Nothing to Compile, this is a binary package"
}

src_install () {
	dodir /opt/myster
	mv ${S}/* ${D}/opt/myster
	dodir /opt/myster/bin
	mv ${D}/opt/myster/myster ${D}/opt/myster/bin/
	dodir /etc/env.d
	echo "MYSTERHOME=/opt/myster" >> ${D}/etc/env.d/50myster
	echo "PATH=/opt/myster/bin" >> ${D}/etc/env.d/50myster
}
