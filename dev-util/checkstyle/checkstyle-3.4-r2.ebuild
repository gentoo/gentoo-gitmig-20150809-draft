# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/checkstyle/checkstyle-3.4-r2.ebuild,v 1.4 2004/10/21 12:14:24 blubb Exp $

inherit java-pkg

DESCRIPTION="A development tool to help programmers write Java code that adheres to a coding standard."
HOMEPAGE="http://checkstyle.sourceforge.net"
SRC_URI="mirror://sourceforge/checkstyle/${PN}-src-${PV}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE="doc jikes"
RESTRICT="nomirror"

S=${WORKDIR}/${PN}-src-${PV}

DEPEND=">=virtual/jdk-1.4
		>=dev-java/ant-1.5
		jikes? ( dev-java/jikes )"

RDEPEND=">=virtual/jre-1.3
		dev-java/antlr
		dev-java/commons-beanutils
		=dev-java/commons-cli-1*
		dev-java/commons-collections
		dev-java/commons-logging
		>=dev-java/regexp-1.3-r1"

src_unpack() {
	unpack ${A}
	cd ${S}/lib
	java-pkg_jar-from antlr
	java-pkg_jar-from commons-beanutils
	java-pkg_jar-from commons-cli-1
	java-pkg_jar-from commons-collections
	java-pkg_jar-from commons-logging
	java-pkg_jar-from regexp regexp.jar jakarta-regexp-1.3.jar
	#if use junit; then
	#	java-pkg_jar-from junit
	#else
		rm junit.jar
	#fi
}

src_compile() {
	local antflags="compile.checkstyle"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "ant :("
}

src_install() {
	insinto /usr/share/checkstyle
	jar cfm ${PN}.jar config/manifest.mf -C target/checkstyle .
	java-pkg_dojar ${PN}.jar
	use doc && java-pkg_dohtml -r docs/*
	dodoc README RIGHTS.antlr TODO
	mv docs/checkstyle_checks.xml ${D}/usr/share/checkstyle/checkstyle_checks.xml
	mv docs/sun_checks.xml ${D}/usr/share/checkstyle/sun_checks.xml
	mv contrib ${D}/usr/share/checkstyle
}
