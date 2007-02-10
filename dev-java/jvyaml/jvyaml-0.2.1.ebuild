# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jvyaml/jvyaml-0.2.1.ebuild,v 1.1 2007/02/10 19:27:23 nichoj Exp $

inherit java-pkg-2 java-ant-2 eutils

DESCRIPTION="Java YAML parser and emitter"
HOMEPAGE="https://jvyaml.dev.java.net/"
SRC_URI="https://${PN}.dev.java.net/files/documents/5215/41455/${PN}-src-${PV}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="source test"
DEPEND=">=virtual/jdk-1.4
	test? (
		dev-java/ant
		dev-java/junit
	)
	!test? (
		dev-java/ant-core
	)
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-0.2-tests.patch

	cd lib
	rm *.jar
	use test && java-pkg_jar-from junit
}

src_install() {
	java-pkg_dojar lib/${PN}.jar
	dodoc README
	dodoc CREDITS
	use source && java-pkg_dosrc src/*
}

src_test() {
	ewarn "Tests are known to fail in some timezones. See"
	ewarn "https://jvyaml.dev.java.net/issues/show_bug.cgi?id=5"
	eant test
}
