# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/vecmath-objectclub/vecmath-objectclub-1.14.ebuild,v 1.1 2007/05/22 05:58:01 je_fro Exp $

inherit java-pkg-2

MY_PN="${PN/-objectclub/1.2}"
DESCRIPTION=" Unofficial free implementation of Sun javax.vecmath by Kenji Hiranabe"
HOMEPAGE="http://www.objectclub.jp/download/vecmath_e"
SRC_URI="http://www.objectclub.jp/download/files/vecmath/${MY_PN}-${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=virtual/jdk-1.4"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/${MY_PN}-${PV}"

src_unpack() {
	unpack ${A}
	mkdir "${S}/classes"
}

src_compile() {
	find javax/ -name "*.java" > "${T}/src.list"
	ejavac -d "${S}/classes" "@${T}/src.list"

	cd "${S}/classes"
	jar -cf "${S}/${PN}.jar" * || die "failed to create jar"
}

src_install() {
	java-pkg_dojar "${S}/${PN}.jar"
	dodoc README
}
