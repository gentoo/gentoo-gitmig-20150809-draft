# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/freemind/freemind-0.6.7.ebuild,v 1.1 2004/02/15 04:16:10 zx Exp $

DESCRIPTION="Mind-mapping software written in Java"
HOMEPAGE="http://freemind.sf.net"
SRC_URI="mirror://sourceforge/freemind/${PN}-src-${PV//./_}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE="doc"
DEPEND=""
DEPEND="dev-java/ant
		>=virtual/jdk-1.4*"

S=${WORKDIR}/src

src_install() {
	ant -Ddist="${D}/opt/${PN}" jar browser
	use doc && ant -Ddist="${D}/usr/share/doc/${P}" doc
	echo "#!/bin/sh" > ${PN}.sh
	echo "cd /opt/${PN}" >> ${PN}.sh
	echo "'${JAVA_HOME}'/bin/java -jar lib/${PN}.jar" >> ${PN}.sh

	insinto /opt/${PN}
	doins html/*

	insinto /opt/${PN}/accessories
	doins accessories/*

	into /opt
	newbin ${PN}.sh ${PN}
}

