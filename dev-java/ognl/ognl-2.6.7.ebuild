# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ognl/ognl-2.6.7.ebuild,v 1.3 2006/01/23 06:37:06 karltk Exp $

inherit java-pkg

DESCRIPTION="Object-Graph Navigation Language; it is an expression language for getting and setting properties of Java objects"
HOMEPAGE="http://www.ognl.org/"
SRC_URI="http://www.ognl.org/${PV}/${P}-dist.zip"

LICENSE="OpenSymphony-1.1"
SLOT="2.6"
KEYWORDS="~x86 ~amd64"
IUSE="doc source"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	${RDEPEND}"
RDEPEND=">=virtual/jre-1.4
	dev-java/javacc
	=dev-java/javassist-3.1*"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cd ${S}/lib
	java-pkg_jar-from javacc
	java-pkg_jar-from javassist-3.1
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc-doc -Djavadoc.output=doc/api"
	ant ${antflags} || die "ant failed"
}

src_install() {
	java-pkg_newjar ${P}.jar ${PN}.jar

	use doc && java-pkg_dohtml -r doc/api
	use source && java-pkg_dosrc java/*
}
