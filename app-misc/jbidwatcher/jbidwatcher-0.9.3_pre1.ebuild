# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/jbidwatcher/jbidwatcher-0.9.3_pre1.ebuild,v 1.2 2004/03/06 14:44:58 zx Exp $

inherit java-pkg

DESCRIPTION="Ebay Bidder Tools for Sniping"
HOMEPAGE="http://jbidwatcher.sf.net/"
SRC_URI="mirror://sourceforge/jbidwatcher/${P/_/}.tar.gz"
LICENSE="LGPL-2.1"
IUSE="jikes"
SLOT="0"
KEYWORDS="~x86"
DEPEND=">=virtual/jdk-1.4
		dev-java/ant
		jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}/${P/_/}

src_compile(){
	sed -i 's:${user.home}/.jbidwatcher:.:' build.xml
	sed -i 's:jikes:modern:' build.xml

	local antflags="jar"
	use jikes && antflags="${antflags} Dbuild.compiler=jikes"
	ant ${antflags}
}

src_install() {
	java-pkg_dojar *.jar

	echo "#!/bin/sh" > ${PN}
	echo "cd /usr/share/${PN}" >> ${PN}
	echo '${JAVA_HOME}'/bin/java -jar lib/JBidWatch-${PV/_/}.jar '$*' >> ${PN}

	dobin ${PN}
}
