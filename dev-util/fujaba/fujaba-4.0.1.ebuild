# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/fujaba/fujaba-4.0.1.ebuild,v 1.6 2004/11/03 11:47:03 axxo Exp $

MY_PV="${PV//./_}"
MY_PNB="Fujaba_${PV:0:1}"

DESCRIPTION="The Fujaba Tool Suite provides an easy to extend UML and Java development platform"
HOMEPAGE="http://www.uni-paderborn.de/cs/fujaba/index.html"
SRC_URI="ftp://ftp.uni-paderborn.de/private/fujaba/${MY_PNB}/FujabaToolSuite_Developer${MY_PV}.zip"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
RDEPEND=">=virtual/jdk-1.4.1"
DEPEND="app-arch/unzip"
S=${WORKDIR}

src_compile() { :; }

src_install() {
	dodir /opt/${PN}
	cp -a . ${D}/opt/${PN}
	chmod -R 755 ${D}/opt/${PN}/

	echo "#!/bin/sh" > ${PN}
	echo "cd /opt/${PN}" >> ${PN}
	echo '${JAVA_HOME}'/bin/java -jar ${PN}.jar '$*' >> ${PN}
	into /opt
	dobin ${PN}
}
