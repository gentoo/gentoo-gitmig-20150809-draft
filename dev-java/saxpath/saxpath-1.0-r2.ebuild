# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/saxpath/saxpath-1.0-r2.ebuild,v 1.2 2006/10/05 17:15:33 gustavoz Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="A Simple API for XPath."
HOMEPAGE="http://saxpath.sourceforge.net/"
SRC_URI="mirror://sourceforge/saxpath/${P}.tar.gz"
LICENSE="saxpath"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc source test"

RDEPEND=">=virtual/jre-1.4"
# doc needs ant-trax
# test needs ant-junit
DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	doc? ( dev-java/ant-tasks )
	test? (
		dev-java/junit
		dev-java/ant-tasks
	)
	source? ( app-arch/zip )
	${RDEPEND}"

S=${WORKDIR}/${P}-FCS

src_unpack() {
	unpack ${A}
	cd "${S}"

	rm -f *.jar lib/*.jar

	mkdir src/conf
	cp ${FILESDIR}/MANIFEST.MF src/conf

	# add a property to pass junit's classpath to javac compile-tests 
	use test && xml-rewrite.py -f build.xml --change -e javac -a classpath \
		-v '${gentoo.classpath}' -i 1
}

src_compile() {
	eant package $(use_doc doc javadoc)
}

src_test() {
	eant -Dgentoo.classpath="$(java-pkg_getjar --build-only junit junit.jar)" \
		test
}

src_install() {
	java-pkg_dojar build/saxpath.jar

	if use doc; then
		mv build/doc/javadoc build/doc/apidocs
		java-pkg_dohtml -r build/doc/*
	fi
	use source && java-pkg_dosrc src/java/main/*
}
