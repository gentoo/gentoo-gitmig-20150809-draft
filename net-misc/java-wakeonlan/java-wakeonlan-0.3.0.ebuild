# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/java-wakeonlan/java-wakeonlan-0.3.0.ebuild,v 1.7 2005/07/16 20:18:56 axxo Exp $

inherit java-pkg

DESCRIPTION="A wakeonlan commandline tool and Java library"
SRC_URI="http://www.moldaner.de/wakeonlan/download/${P/java-/}-src.zip"
HOMEPAGE="http://www.moldaner.de/wakeonlan/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"
IUSE="doc"

RDEPEND=">=virtual/jre-1.3
	>=dev-java/commons-logging-1.0.2
	>=dev-java/commons-cli-1.0"
DEPEND=">=virtual/jdk-1.3
	${RDEPEND}
	dev-java/ant-core
	app-arch/unzip"

S=${WORKDIR}/wakeonlan

src_unpack() {
	unpack ${A}
	cd ${S}/lib
	rm *.jar
	java-pkg_jarfrom commons-logging
	java-pkg_jarfrom commons-cli-1
}

src_compile() {
	local antflags="deploy"
	use doc && antflags="${antflags} javadoc"
	ant ${antflags} || die
}

src_install() {
	java-pkg_dojar deploy/wakeonlan.jar

	echo "#!/bin/sh" > ${PN}
	echo '${JAVA_HOME}'/bin/java -cp '$(java-config -p commons-logging,commons-cli-1,java-wakeonlan)' wol.WakeOnLan '$*' >> ${PN}
	dobin ${PN}

	dodoc doc/README
	use doc && java-pkg_dohtml -r deploy/doc/javadoc/*
}
