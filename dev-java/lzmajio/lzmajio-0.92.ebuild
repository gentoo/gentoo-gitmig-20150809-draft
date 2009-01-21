# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/lzmajio/lzmajio-0.92.ebuild,v 1.1 2009/01/21 22:26:52 tommy Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Implementations of LzmaInputStream/LzmaOutputStream interacting with underlying LZMA en-/decoders"
HOMEPAGE="http://contrapunctus.net/league/haques/lzmajio/"
SRC_URI="http://comsci.liu.edu/~league/dist/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

COMMON_DEP="<=dev-java/lzma-4.60"

RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	app-arch/unzip
	${COMMON_DEP}"

EANT_GENTOO_CLASSPATH="lzma"

src_unpack() {
	unpack ${A}
	cd "${S}" || die
	java-pkg_jar-from lzma
	cp "${FILESDIR}"/build.xml . || die
}

src_install() {
	java-pkg_dojar ${PN}.jar
	use doc && java-pkg_dojavadoc docs
	use source && java-pkg_dosrc lzmajio
}

