# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/myster/myster-8.0.ebuild,v 1.5 2004/07/31 02:28:01 squinky86 Exp $

inherit java-pkg

MY_PV=${PV/.0/}
DESCRIPTION="Myster is a decentralized file sharing network"
HOMEPAGE="http://www.mysternetworks.com/"
SRC_URI="mirror://sourceforge/myster/Myster_PR${MY_PV}_Generic.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND=">=virtual/jdk-1.4"
RDEPEND=">=virtual/jre-1.4"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	mv "Myster PR ${MY_PV} Generic" ${P}
	chmod -R go-w ${S}
	echo "java -jar /opt/myster/Myster.jar" >> ${T}/myster
	echo "MYSTERHOME=/opt/myster" >> ${T}/50myster
	echo "PATH=/opt/myster/bin" >> ${T}/50myster
}

src_compile () {
	einfo "Nothing to Compile, this is a binary package"
}

src_install () {
	dodir /opt/myster
	cp -R * ${D}/opt/myster || die "cp failed"
	exeinto /opt/myster/bin
	doexe ${T}/myster || die "doexe failed"
	insinto /etc/env.d
	doins ${T}/50myster || die "doins failed"
}
