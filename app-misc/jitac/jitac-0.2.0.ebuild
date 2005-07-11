# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/jitac/jitac-0.2.0.ebuild,v 1.9 2005/07/11 21:04:39 axxo Exp $

DESCRIPTION="An image to ASCII converter written in Java"
HOMEPAGE="http://www.roqe.org/jitac/"
SRC_URI="http://www.roqe.org/jitac/${P}.jar"
LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 ppc ~sparc x86"
IUSE=""
RDEPEND="virtual/jre"


S=${WORKDIR}

src_unpack() {
	cp ${DISTDIR}/${A} ${WORKDIR}/
}

src_install() {
	insinto /opt/${PN}/lib
	doins ${P}.jar

	echo "#!/bin/sh" > ${PN}
	echo "cd /opt/${PN}" >> ${PN}
	echo '${JAVA_HOME}'/bin/java -jar lib/${P}.jar '$*' >> ${PN}

	into /opt
	dobin ${PN}
}

