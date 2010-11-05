# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/tuprolog/tuprolog-2.3.0_alpha.ebuild,v 1.5 2010/11/05 23:55:42 keri Exp $

inherit eutils java-pkg-2 java-ant-2

MY_P="2p-${PV/_/}"
MY_SRC_P="src-J2SE-${PV}"

DESCRIPTION="tuProlog is a light-weight Prolog for Internet applications and infrastructures"
HOMEPAGE="http://www.alice.unibo.it/tuProlog/"
SRC_URI="mirror://sourceforge/tuprolog/${MY_P}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

RDEPEND=">=virtual/jdk-1.5
	>=dev-java/javassist-3"

DEPEND="${RDEPEND}
	app-arch/unzip
	dev-java/ant-core"

S="${WORKDIR}"

EANT_GENTOO_CLASSPATH="javassist-3"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-generics.patch
	epatch "${FILESDIR}"/${P}-javadocs.patch

	cp "${FILESDIR}"/build.xml "${S}" || die
}

src_compile() {
	eant jar $(use_doc)
}

src_install() {
	java-pkg_dojar dist/${PN}.jar

	if use doc ; then
		java-pkg_dohtml -r docs/* || die
	fi

	dodoc CHANGELOG || die
}
