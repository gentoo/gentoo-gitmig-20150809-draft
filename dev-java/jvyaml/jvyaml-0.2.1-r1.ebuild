# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jvyaml/jvyaml-0.2.1-r1.ebuild,v 1.3 2007/03/09 00:29:18 betelgeuse Exp $

JAVA_PKG_IUSE="doc source test"

inherit java-pkg-2 java-ant-2 eutils

DESCRIPTION="Java YAML parser and emitter"
HOMEPAGE="https://jvyaml.dev.java.net/"
SRC_URI="https://${PN}.dev.java.net/files/documents/5215/41455/${PN}-src-${PV}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND=">=virtual/jdk-1.4
	test? (
		dev-java/ant
		dev-java/junit
	)
	dev-java/ant-core"
RDEPEND=">=virtual/jre-1.4"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# https://jvyaml.dev.java.net/issues/show_bug.cgi?id=6
	epatch "${FILESDIR}/${PN}-0.2-tests.patch"

	# https://jvyaml.dev.java.net/issues/show_bug.cgi?id=5
	epatch "${FILESDIR}/${P}-tests.patch"

	cd lib
	rm -v *.jar || die
	use test && java-pkg_jar-from --build-only junit
}

src_install() {
	java-pkg_dojar lib/${PN}.jar
	dodoc README CREDITS || die
	use source && java-pkg_dosrc src/*
}

src_test() {
	eant test
}
