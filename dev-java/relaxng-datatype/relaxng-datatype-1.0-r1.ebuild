# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/relaxng-datatype/relaxng-datatype-1.0-r1.ebuild,v 1.3 2006/12/09 09:23:33 flameeyes Exp $

inherit java-pkg-2 java-ant-2 eutils

MY_PN="relaxngDatatype"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Interface between RELAX NG validators and datatype libraries"
HOMEPAGE="http://relaxng.org/"
SRC_URI="mirror://sourceforge/relaxng/${MY_P}.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="doc source"

DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	source? ( app-arch/zip )
	dev-java/ant-core"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -f *.jar
	epatch ${FILESDIR}/${P}-build_xml.patch
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"

	eant ${antflags} || die "Compilation failed"
}

src_install() {
	java-pkg_dojar ${MY_PN}.jar
	dodoc README.txt

	use doc && java-pkg_dohtml -r doc/api
	use source && java-pkg_dosrc src/*
}
