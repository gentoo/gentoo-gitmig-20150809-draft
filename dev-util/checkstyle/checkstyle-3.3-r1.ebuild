# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/checkstyle/checkstyle-3.3-r1.ebuild,v 1.1 2005/03/27 21:15:36 luckyduck Exp $

inherit java-pkg

DESCRIPTION="A development tool to help programmers write Java code that adheres to a coding standard."
HOMEPAGE="http://checkstyle.sourceforge.net"
SRC_URI="mirror://sourceforge/checkstyle/${PN}-src-${PV}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64"
IUSE="doc jikes"

S=${WORKDIR}/${PN}-src-${PV}

DEPEND=">=virtual/jdk-1.4
		>=dev-java/ant-1.5
		jikes? ( dev-java/jikes )"

RDEPEND=">=virtual/jre-1.3
		dev-java/antlr
		dev-java/commons-beanutils
		dev-java/commons-cli
		dev-java/commons-collections
		dev-java/commons-logging
		=dev-java/jakarta-regexp-1.3*"

src_compile() {
	local antflags="compile.checkstyle"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "ant :("
}

src_install() {
	insinto /usr/share/checkstyle
	jar cfm ${P}.jar config/manifest.mf -C target/checkstyle .
	java-pkg_dojar ${P}.jar
	use doc && java-pkg_dohtml -r docs/*
	dodoc README RIGHTS.antlr TODO
	mv docs/checkstyle_checks.xml ${D}/usr/share/checkstyle/checkstyle_checks.xml
	mv docs/sun_checks.xml ${D}/usr/share/checkstyle/sun_checks.xml
	mv contrib ${D}/usr/share/checkstyle

	echo '#!/bin/bash' > checkstyle
	echo '' >> checkstyle
	echo '`java-config -J` -cp `java-config -p checkstyle,antlr,commons-beanutils,commons-cli-1,commons-collections,commons-logging,jakarta-regexp-1.3` com.puppycrawl.tools.checkstyle.Main "$@"' >> checkstyle

	insinto /usr
	dobin checkstyle
}
