# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jexcelapi/jexcelapi-2.5.1.ebuild,v 1.1 2005/01/23 14:50:15 luckyduck Exp $

inherit eutils java-pkg

MY_P="${P//-/_}"
MY_P="${MY_P//./_}"

DESCRIPTION="A Java API to read, write, and modify Excel spreadsheets"
HOMEPAGE="http://jexcelapi.sourceforge.net/"
SRC_URI="mirror://sourceforge/jexcelapi/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="2.5"
KEYWORDS="~x86 ~amd64"

IUSE="doc jikes"
DEPEND=">=virtual/jdk-1.3
		dev-java/ant-core
		jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.3"
RESTRICT="nomirror"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PV}-jikes.patch

	rm -rf jxl.jar docs
}

src_compile() {
	local antflags="jxl"
	use doc && antflags="${antflags} docs"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"

	cd ${S}/build
	ant ${antflags} || die "ant failed"
}

src_install() {
	mv jxl.jar ${PN}.jar
	java-pkg_dojar ${PN}.jar

	java-pkg_dohtml index.html tutorial.html
	use doc && java-pkg_dohtml -r docs/*
}
