# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mindterm-bin/mindterm-bin-2.4.2.ebuild,v 1.2 2004/11/03 11:56:31 axxo Exp $

DESCRIPTION="A Java SSH Client"
HOMEPAGE="http://www.appgate.com/products/80_MindTerm/"
SRC_URI="http://www.appgate.com/products/80_MindTerm/110_MindTerm_Download/${PN%%-bin}_${PV}-bin.zip"

LICENSE="mindterm"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE=""
RDEPEND="virtual/x11
	virtual/jre"
DEPEND="app-arch/unzip"
S=${WORKDIR}

src_install() {
	insinto /opt/${PN}/lib
	doins ${PN%%-bin}.jar

	echo "#!/bin/sh" > ${PN}
	echo "cd /opt/${PN}" >> ${PN}
	echo '${JAVA_HOME}'/bin/java -jar lib/${PN%%-bin}.jar '$*' >> ${PN}

	into /opt
	dobin ${PN}

	dodoc README.txt
}

