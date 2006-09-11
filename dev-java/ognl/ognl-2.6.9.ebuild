# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ognl/ognl-2.6.9.ebuild,v 1.1 2006/09/11 16:39:50 nelchael Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Object-Graph Navigation Language; it is an expression language for getting and setting properties of Java objects"
HOMEPAGE="http://www.ognl.org/"
SRC_URI="http://www.ognl.org/${PV}/${P}-dist.zip
	https://ognl.dev.java.net/source/browse/*checkout*/ognl/osbuild.xml"

LICENSE="OpenSymphony-1.1"
SLOT="2.6"
KEYWORDS="~x86 ~amd64"
IUSE="doc source"

RDEPEND=">=virtual/jre-1.4
	dev-java/javacc
	=dev-java/javassist-3.1*"

DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	dev-java/ant-core
	dev-java/ant-contrib
	${RDEPEND}"

S="${WORKDIR}"

src_unpack() {

	unpack ${A}

	cp "${DISTDIR}/osbuild.xml" "${S}/"

}

src_compile() {

	cd "${S}/lib/build"
	rm -f *.jar
	java-pkg_jar-from javacc
	java-pkg_jar-from javassist-3.1

	cd "${S}"
	local antflags="jar"
	use doc && antflags="${antflags} javadocs"
	eant ${antflags} || die "ant failed"

}

src_install() {

	java-pkg_newjar build/${P}.jar ${PN}.jar

	use doc && java-pkg_dohtml -r dist/docs/api
	use source && java-pkg_dosrc src/java/*

}
