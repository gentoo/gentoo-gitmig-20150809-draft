# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/dtdparser/dtdparser-1.21.ebuild,v 1.3 2005/05/04 18:02:16 luckyduck Exp $

inherit eutils java-pkg

DESCRIPTION="A Java DTD Parser"
HOMEPAGE="http://www.wutka.com/dtdparser.html"
SRC_URI="http://www.wutka.com/download/${P}.tgz"

LICENSE="LGPL-2.1 Apache-1.1"
SLOT="${PV}"
KEYWORDS="x86 amd64 ~ppc"
IUSE="doc jikes source"

DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-core-1.4
	jikes? ( >=dev-java/jikes-1.21 )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.3"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/buildfile.patch
}

src_compile() {
	local antflags="build"
	use doc && antflags="${antflags} createdoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "failed to build"
}

src_install() {
	java-pkg_dojar dist/${PN}.jar
	dodoc CHANGES README

	use doc && java-pkg_dohtml -r doc/*
	use source && java-pkg_dosrc source/*
}
