# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/java-wakeonlan/java-wakeonlan-0.3.0.ebuild,v 1.2 2004/02/18 20:00:27 zx Exp $

inherit java-pkg

DESCRIPTION="A wakeonlan commandline tool and Java library"
SRC_URI="http://www.moldaner.de/wakeonlan/download/${P/java-/}-src.zip"
HOMEPAGE="http://www.moldaner.de/wakeonlan/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE="doc"

DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-1.4
	>=dev-java/commons-logging-1.0.2
	 >=dev-java/commons-cli-1.0"
RDEPEND=">=virtual/jdk-1.3"

S=${WORKDIR}/wakeonlan

src_compile() {
	rm lib/commons-cli-1.0.jar
	rm lib/commons-logging.jar

	CLASSPATH=`java-config --classpath=commons-logging,commons-cli`
	ant -Dbuild.classpath=${CLASSPATH} deploy || die
	use doc && ant -Dbuild.classpath=${CLASSPATH} javadoc
}

src_install() {
	java-pkg_dojar deploy/wakeonlan.jar

	local my_cp
	my_cp=`java-config --classpath=commons-logging,commons-cli,java-wakeonlan`

	echo "#!/bin/sh" > ${PN}
	echo '${JAVA_HOME}'/bin/java -cp ${my_cp} wol.WakeOnLan '$*' >> ${PN}
	dobin ${PN}

	dodoc doc/README
	use doc && dohtml -r deploy/doc/javadoc/*
}
