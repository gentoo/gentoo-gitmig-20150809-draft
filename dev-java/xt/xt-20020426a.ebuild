# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xt/xt-20020426a.ebuild,v 1.5 2004/11/14 18:55:28 axxo Exp $

inherit java-pkg

MY_P="${PN}-${PV}-src"

DESCRIPTION="Java Implementation of XSL-Transformations"
SRC_URI="http://www.blnz.com/xt/${MY_P}.tgz"
HOMEPAGE="http://www.blnz.com/xt/"
LICENSE="JamesClark"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="doc jikes"

DEPEND=">=virtual/jdk-1.4
	>=dev-java/xp-0.5
	~dev-java/servletapi-2.3
	>=dev-java/xerces-2.6.2-r1"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -f xt.jar lib/*.jar
	cd lib
	java-pkg_jar-from xerces-2 xml-apis.jar
	java-pkg_jar-from xp
	java-pkg_jar-from servletapi-2.3 servletapi-2.3.jar servlets.jar
}

src_compile() {
	cd src
	emake || die "compile failed"
}

src_install() {
	java-pkg_dojar xt.jar
	dohtml README copying.txt copyingjc.txt index.html
	use doc && java-pkg_dohtml -r docs/*
}
