# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdom/jdom-1.0_beta10-r1.ebuild,v 1.3 2004/10/17 07:29:20 absinthe Exp $

inherit java-pkg

IUSE="jikes doc"

MY_PN="jdom"
MY_PV="b10"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Java API to manipulate XML data"
SRC_URI="http://www.jdom.org/dist/source/${MY_P}.tar.gz"
HOMEPAGE="http://www.jdom.org"
LICENSE="JDOM"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
RDEPEND=">=virtual/jdk-1.3"
DEPEND=">=dev-java/ant-1.4.1
		dev-java/jaxen
		dev-java/saxpath
		dev-java/xalan
		>=dev-java/xerces-2.6.2-r1
		jikes? ( >=dev-java/jikes-1.15 )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -f build/*.jar lib/*.jar

	cd ${S}/lib
	java-pkg_jar-from jaxen
	java-pkg_jar-from saxpath
	java-pkg_jar-from xerces-2
}

src_compile() {
	local antflags="package"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compile problem"
}

src_install() {
	java-pkg_dojar \
		build/*.jar

	dodoc CHANGES.txt COMMITTERS.txt LICENSE.txt README.txt TODO.txt
	use doc && java-pkg_dohtml -r build/apidocs/*
}

pkg_postinst() {
	einfo
	einfo "Online Documentation:"
	einfo "     http://www.jdom.org/downloads/docs.html"
	einfo
}
