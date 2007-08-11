# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/tuprolog/tuprolog-2.1.ebuild,v 1.7 2007/08/11 17:10:36 beandog Exp $

inherit eutils java-pkg-2 java-ant-2

MY_P="2p-${PV}"
MY_SRC_P="src-J2SE-${PV}"

DESCRIPTION="tuProlog is a light-weight Prolog for Internet applications and infrastructures"
HOMEPAGE="http://www.alice.unibo.it/tuProlog/"
SRC_URI="mirror://sourceforge/tuprolog/2p-2.1.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="doc test"

DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	dev-java/ant-core
	test? ( dev-java/ant-junit )"
RDEPEND=">=virtual/jdk-1.4"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-java1.4.patch
	epatch "${FILESDIR}"/${P}-javadocs.patch
	epatch "${FILESDIR}"/${P}-junit.patch

	cd "${S}"
	cp "${FILESDIR}"/build.xml "${S}"
}

src_compile() {
	eant jar $(use_doc)
}

src_test() {
	cd "${S}"/dist
	java-pkg_jar-from junit
	cd "${S}"
	ANT_TASKS="ant-junit" eant test || die "eant test failed"
}

src_install() {
	java-pkg_dojar dist/${PN}.jar

	if use doc ; then
		java-pkg_dohtml -r docs/*
		dodoc doc/*.pdf
	fi

	dodoc CHANGELOG
}
