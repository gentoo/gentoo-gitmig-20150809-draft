# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jgoodies-binding/jgoodies-binding-1.1.2.ebuild,v 1.1 2007/01/10 21:43:12 betelgeuse Exp $

inherit java-pkg-2 java-ant-2

MY_V=${PV//./_}
DESCRIPTION="A Java library to bind object properties with UI components"
HOMEPAGE="http://www.jgoodies.com/"
SRC_URI="http://www.jgoodies.com/download/libraries/binding-${MY_V}.zip"

LICENSE="BSD"
SLOT="1.0"
KEYWORDS="~x86"
IUSE="doc examples source"

COMMON_DEP=">=dev-java/jgoodies-looks-1.0.5"
DEPEND=">=virtual/jdk-1.4.2
		${COMMON_DEP}
		dev-java/ant-core
		app-arch/unzip
		source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4.2
		${COMMON_DEP}"

S=${WORKDIR}/binding-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Clean up the directory structure
	rm -rvf *.jar lib

	# Copy the Gentoo'ized build.xml
	# cp ${FILESDIR}/build-${PV}.xml ${S}
	xml-rewrite.py -f build.xml -d -e javac -a bootclasspath \
		|| die "Failed to fix bootclasspath"
}
src_compile() {
	eant jar # precompile javadocs
}

RESTRICT="test"
# Needs X
#src_test() {
#	eant test -D\
#		-Djunit.jar=$(java-pkg_getjar junit junit.jar)
#}

src_install() {
	java-pkg_dojar build/binding.jar

	dodoc RELEASE-NOTES.txt
	dohtml README.html
	use doc && java-pkg_dohtml -r docs/*
	use source && java-pkg_dosrc src/core/*
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r src/tutorial/com
	fi
}
