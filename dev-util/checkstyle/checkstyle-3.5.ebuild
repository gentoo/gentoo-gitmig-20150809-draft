# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/checkstyle/checkstyle-3.5.ebuild,v 1.5 2005/08/14 10:06:32 hansmi Exp $

inherit java-pkg

DESCRIPTION="A development tool to help programmers write Java code that adheres to a coding standard."
HOMEPAGE="http://checkstyle.sourceforge.net"
SRC_URI="mirror://sourceforge/checkstyle/${PN}-src-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE="doc jikes"

RDEPEND=">=virtual/jre-1.3
		dev-java/antlr
		=dev-java/commons-beanutils-1.6*
		=dev-java/commons-cli-1*
		dev-java/commons-collections
		dev-java/commons-logging
		=dev-java/jakarta-regexp-1.3*"
DEPEND=">=virtual/jdk-1.4
		${RDEPEND}
		dev-java/ant-core
		jikes? ( dev-java/jikes )"
S=${WORKDIR}/${PN}-src-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}/lib
	rm *.jar
	java-pkg_jar-from antlr
	java-pkg_jar-from commons-beanutils-1.6
	java-pkg_jar-from commons-cli-1
	java-pkg_jar-from commons-collections
	java-pkg_jar-from commons-logging
	java-pkg_jar-from jakarta-regexp-1.3 jakarta-regexp.jar jakarta-regexp-1.3.jar
}

src_compile() {
	local antflags="compile.checkstyle"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "ant :("
}

src_install() {
	insinto /usr/share/checkstyle
	jar cfm ${PN}.jar config/manifest.mf -C target/checkstyle . || die
	java-pkg_dojar ${PN}.jar
	use doc && java-pkg_dohtml -r docs/*
	dodoc README RIGHTS.antlr TODO
	mv docs/checkstyle_checks.xml ${D}/usr/share/checkstyle/checkstyle_checks.xml
	mv docs/sun_checks.xml ${D}/usr/share/checkstyle/sun_checks.xml
	mv contrib ${D}/usr/share/checkstyle

	echo '#!/bin/bash' > checkstyle
	echo '' >> checkstyle
	echo '`java-config -J` -cp `java-config -p checkstyle,antlr,commons-beanutils-1.6,commons-cli-1,commons-collections,commons-logging,jakarta-regexp-1.3` com.puppycrawl.tools.checkstyle.Main "$@"' >> checkstyle

	dobin checkstyle

	dodir /usr/share/ant-core/lib
	dosym /usr/share/${PN}/lib/${PN}.jar /usr/share/ant-core/lib/
}
