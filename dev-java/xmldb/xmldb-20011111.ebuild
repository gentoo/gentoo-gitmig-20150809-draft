# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xmldb/xmldb-20011111.ebuild,v 1.1 2005/06/29 18:28:30 axxo Exp $

inherit java-pkg eutils

MY_PN="${PN}-api"
MY_PV="11112001"
MY_P="${MY_PN}-${MY_PV}"
DESCRIPTION="XML:DB provides a community for collaborative development of specifications for XML databases and data manipulation technologies."
HOMEPAGE="http://sourceforge.net/projects/xmldb-org/"
SRC_URI="mirror://sourceforge/xmldb-org/${MY_P}.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc jikes source"

DEPEND=">=virtual/jdk-1.4
	jikes? ( dev-java/jikes )
	dev-java/ant-core"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-unreachable.patch

	mkdir src && mv org src
	cp ${FILESDIR}/build-${PVR}.xml build.xml
}

src_compile() {
	local antflags="jar"
	use jikes && antflags="-Dbuild.compiler=jikes ${antflags}"
	use doc && antflags="${antflags} javadoc"

	ant ${antflags} || die "Compilation failed"
}

src_install() {
	java-pkg_dojar dist/*.jar

	use doc && java-pkg_dohtml -r dist/doc/api
	use source && java-pkg_dosrc src/*
}
