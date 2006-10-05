# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/blowfishj/blowfishj-2.14-r1.ebuild,v 1.2 2006/10/05 15:11:33 gustavoz Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Blowfish implementation in Java"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.gz"
HOMEPAGE="http://blowfishj.sourceforge.net/index.html"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="doc test"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant
	app-arch/unzip
	test? ( dev-java/junit ) "
RDEPEND=">=virtual/jre-1.4"

src_compile() {
	eant jar $(use_doc) || die "failed to compile"
}

src_test() {
	eant test || die "test failed"
}

src_install() {
	java-pkg_newjar target/${P}.jar ${PN}.jar

	use doc && java-pkg_dohtml -r dist/docs/api/*
}
