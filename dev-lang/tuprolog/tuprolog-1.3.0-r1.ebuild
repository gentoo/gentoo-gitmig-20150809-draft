# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/tuprolog/tuprolog-1.3.0-r1.ebuild,v 1.1 2006/10/04 06:38:53 keri Exp $

inherit eutils java-pkg-2 java-ant-2

MY_P="2p-${PV}"
MY_SRC_P="src-J2SE-${PV}"

DESCRIPTION="tuProlog is a light-weight Prolog for Internet applications and infrastructures"
HOMEPAGE="http://www.alice.unibo.it:8080/tuProlog/"
SRC_URI="http://www.alice.unibo.it/download/tuprolog/files/core/${MY_P}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="doc"

DEPEND=">=virtual/jdk-1.3
	app-arch/unzip
	dev-java/ant-core"
RDEPEND=">=virtual/jdk-1.3"

S="${WORKDIR}"/${P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	cp "${FILESDIR}"/build.xml "${S}"

	cd "${S}"/src
	unpack ./${MY_SRC_P}.zip

	epatch "${FILESDIR}"/${P}-javadocs.patch
}

src_compile() {
	eant jar $(use_doc)
}

src_install() {
	java-pkg_dojar dist/${PN}.jar

	if use doc ; then
		java-pkg_dohtml -r docs/*
		dodoc doc/*.pdf
	fi
}
