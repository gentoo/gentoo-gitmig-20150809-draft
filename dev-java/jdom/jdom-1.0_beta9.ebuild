# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdom/jdom-1.0_beta9.ebuild,v 1.2 2004/03/19 01:17:14 zx Exp $

inherit java-pkg

IUSE="jikes doc"

MY_PN="jdom"
MY_PV="b9"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Java API to manipulate XML data"
SRC_URI="http://www.jdom.org/dist/source/${MY_P}.tar.gz"
HOMEPAGE="http://www.jdom.org"
LICENSE="JDOM"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc"
RDEPEND=">=virtual/jdk-1.3"
DEPEND=">=dev-java/ant-1.4.1
		dev-java/xalan
		dev-java/xerces
		jikes? ( >=dev-java/jikes-1.15 )"

S="${WORKDIR}/${MY_P}"

src_compile() {
	local antflags

	antflags=""
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"

	ant ${antflags} || die "compile problem"
}

src_install() {
	# install everything except for the jdom11.jar and collections
	# (pre-Java 2 support which interferes)
	java-pkg_dojar \
		build/jdom.jar

	dodoc CHANGES.txt COMMITTERS.txt LICENSE.txt README.txt TODO.txt
	use doc && dohtml -r build/apidocs/*
}

pkg_postinst() {

	einfo
	einfo "Online Documentation:"
	einfo "     http://www.jdom.org/downloads/docs.html"
	einfo

}
