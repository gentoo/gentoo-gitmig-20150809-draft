# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/blowfishj/blowfishj-2.14-r1.ebuild,v 1.3 2007/01/14 17:24:59 betelgeuse Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Blowfish implementation in Java"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.gz"
HOMEPAGE="http://blowfishj.sourceforge.net/index.html"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="doc test source"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	app-arch/unzip
	test? ( dev-java/junit dev-java/ant-tasks ) "
RDEPEND=">=virtual/jre-1.4"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	java-ant_ignore-system-classes
	mkdir -p target/lib
	cd target/lib
	use test && java-pkg_jar-from --build-only junit
}

src_test() {
	eant test -DJunit.present=true || die "test failed"
}

src_install() {
	java-pkg_newjar target/${P}.jar ${PN}.jar

	use doc && java-pkg_dojavadoc dist/docs/api
	use source && java-pkg_dosrc src/java/net
}
