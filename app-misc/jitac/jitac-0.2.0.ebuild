# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/jitac/jitac-0.2.0.ebuild,v 1.1 2004/02/14 20:36:25 zx Exp $

DESCRIPTION="An image to ASCII converter written in Java"
HOMEPAGE="http://www.roqe.org/jitac/"
SRC_URI="http://www.roqe.org/jitac/${P}.jar"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
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

