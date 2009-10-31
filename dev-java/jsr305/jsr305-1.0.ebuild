# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jsr305/jsr305-1.0.ebuild,v 1.1 2009/10/31 02:11:19 nerdboy Exp $

EAPI=2
JAVA_PKG_IUSE="doc source"
inherit eutils java-pkg-2 java-ant-2
MY_PN=jsr-305
ESVN_REPO_URI="http://${MY_PN}.googlecode.com/svn/trunk"
inherit subversion
ESVN_FETCH_CMD="svn checkout -r 49"

DESCRIPTION="Reference implementation for JSR 305: Annotations for Software Defect Detection in Java"
SRC_URI=""
HOMEPAGE="http://code.google.com/p/jsr-305/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="examples"

DEPEND=">=virtual/jdk-1.5
	app-arch/unzip
	test? ( dev-java/ant-junit )"
RDEPEND=">=virtual/jre-1.5"

src_compile() {
	# create jar
	cd ri
	mkdir -p build/classes
	ejavac -sourcepath src/main/java -d build/classes $(find src/main/java -name "*.java") \
		|| die "Cannot compile sources"
	mkdir dist
	cd build/classes
	jar -cvf "${S}"/ri/dist/${PN}.jar javax || die "Cannot create JAR"

	# generate javadoc
	if use doc ; then
		cd "${S}"/ri
		mkdir javadoc
		javadoc -d javadoc -sourcepath src/main/java -subpackages javax \
			|| die "Javadoc creation failed"
	fi
}

src_install() {
	cd ri
	java-pkg_dojar dist/${PN}.jar

	if use examples; then
		dodir /usr/share/doc/${PF}/examples/
		cp -r "${S}"/sampleUses/* "${D}"/usr/share/doc/${PF}/examples/ || die "Could not install examples"
	fi

	if use source ; then
		cd "${S}"/ri/src/main/java
		java-pkg_dosrc javax
	fi

	if use doc ; then
		cd "${S}"/ri
		java-pkg_dojavadoc javadoc
	fi
}
