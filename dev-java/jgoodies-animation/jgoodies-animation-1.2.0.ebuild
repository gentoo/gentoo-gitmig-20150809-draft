# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jgoodies-animation/jgoodies-animation-1.2.0.ebuild,v 1.2 2007/05/27 00:07:08 caster Exp $

JAVA_PKG_IUSE="doc examples source test"

inherit java-pkg-2 java-ant-2

MY_V=${PV//./_}
DESCRIPTION="JGoodies Animation Library"
HOMEPAGE="http://www.jgoodies.com/"
SRC_URI="http://www.jgoodies.com/download/libraries/animation-${MY_V}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	test? ( =dev-java/junit-3* dev-java/ant-junit )"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/animation-${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Remove the packaged jar
	rm -v lib/*.jar *.jar || die

	# cp ${FILESDIR}/build-${PV}.xml ${S}
	java-ant_xml-rewrite -f build.xml -d -e javac -a bootclasspath \
		|| die "Failed to fix bootclasspath"
}
src_compile() {
	eant jar # precompiled javadocs
}

src_test() {
	eant test -Djunit.jar.present=true \
		-Djunit.jar=$(java-pkg_getjar junit junit.jar)
}

src_install() {
	java-pkg_dojar build/animation.jar

	dodoc RELEASE-NOTES.txt
	dohtml README.html
	use doc && java-pkg_dohtml -r docs/*
	use source && java-pkg_dosrc src/core/*
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r src/tutorial/com
	fi
}
