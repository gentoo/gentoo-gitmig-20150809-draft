# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mindterm-bin/mindterm-bin-2.4.1.ebuild,v 1.1 2004/02/15 01:31:52 zx Exp $

DESCRIPTION="A Java SSH Client"
HOMEPAGE="http://www.appgate.com/products/5_MindTerm/"
SRC_URI="http://www.appgate.com/products/5_MindTerm/4_Download/${PN%%-bin}_${PV}-bin.zip"

LICENSE="mindterm"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE=""
RDEPEND="virtual/x11
		virtual/jre"

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

