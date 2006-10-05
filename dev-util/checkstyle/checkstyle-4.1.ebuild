# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/checkstyle/checkstyle-4.1.ebuild,v 1.2 2006/10/05 14:36:58 gustavoz Exp $

inherit java-pkg

MY_P="${PN}-src-${PV}"
DESCRIPTION="A development tool to help programmers write Java code that adheres to a coding standard."
HOMEPAGE="http://checkstyle.sourceforge.net"
SRC_URI="mirror://sourceforge/checkstyle/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc jikes"

RDEPEND=">=virtual/jre-1.3
		dev-java/antlr
		=dev-java/commons-beanutils-1.7*
		=dev-java/commons-cli-1*
		dev-java/commons-collections
		dev-java/commons-logging
		=dev-java/jakarta-regexp-1.3*"
DEPEND=">=virtual/jdk-1.4
		${RDEPEND}
		dev-java/ant-core
		dev-java/ant-tasks
		jikes? ( dev-java/jikes )"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}/lib
	rm *.jar
	java-pkg_jar-from antlr
	java-pkg_jar-from commons-beanutils-1.7
	java-pkg_jar-from commons-cli-1
	java-pkg_jar-from commons-collections
	java-pkg_jar-from commons-logging
	java-pkg_jar-from jakarta-regexp-1.3 jakarta-regexp.jar jakarta-regexp-1.3.jar
}

src_compile() {
	local antflags="compile.checkstyle"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "ant failed"

	jar cfm ${PN}.jar config/manifest.mf -C target/checkstyle . || die "jar failed"
}

src_install() {
	java-pkg_dojar ${PN}.jar

	dodoc README RIGHTS.antlr TODO
	use doc && java-pkg_dohtml -r docs/*

	# Install check files
	insinto /usr/share/checkstyle/checks
	doins checkstyle_checks.xml sun_checks.xml

	# Install extra files
	insinto  /usr/share/checkstyle/contrib
	doins -r contrib/*

	# Make and install a wrapper script
	cat > checkstyle <<-END
#!/bin/bash
classpath=\$(java-config -p checkstyle,antlr,commons-beanutils-1.7,commons-cli-1,commons-collections,commons-logging,jakarta-regexp-1.3)
class=com.puppycrawl.tools.checkstyle.Main
exec \$(java-config --java) -cp \$classpath \$class "\$@"
END
	dobin checkstyle

	# Make the ant tasks available to ant
	dodir /usr/share/ant-core/lib
	dosym /usr/share/${PN}/lib/${PN}.jar /usr/share/ant-core/lib/
}

pkg_postinst() {
	einfo "Checkstyle is located at /usr/bin/checkstyle"
	einfo "Check files are located in /usr/share/checkstyle/checks/"
}
