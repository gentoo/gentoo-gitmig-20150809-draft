# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/jdictionary/jdictionary-1.8.ebuild,v 1.6 2004/11/03 11:56:00 axxo Exp $

DESCRIPTION="A online Java-based dictionary"
HOMEPAGE="http://jdictionary.sourceforge.net/"
SRC_URI="mirror://sourceforge/jdictionary/${P/./_}.zip"
IUSE=""
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ppc ~sparc ~amd64"

RDEPEND=">=virtual/jdk-1.3"
DEPEND="app-arch/unzip"
S=${WORKDIR}/${PN}

src_install() {
	insinto /opt/${PN}/lib
	doins *.jar

	echo "#!/bin/sh" > ${PN}
	echo "cd /opt/${PN}" >> ${PN}
	echo '${JAVA_HOME}'/bin/java -jar lib/${PN}.jar '$*' >> ${PN}

	into /opt
	dobin ${PN}
}
