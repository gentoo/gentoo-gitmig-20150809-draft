# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/dtdparser/dtdparser-1.21.ebuild,v 1.1 2005/01/22 17:46:27 luckyduck Exp $

inherit eutils java-pkg

DESCRIPTION="A Java DTD Parser"
SRC_URI="http://www.wutka.com/download/${P}.tgz"
HOMEPAGE="http://www.wutka.com/dtdparser.html"
LICENSE="LGPL-2.1 Apache-1.1"
SLOT="${PV}"
KEYWORDS="~x86 ~amd64"
IUSE="doc jikes source"
DEPEND=">=virtual/jdk-1.3
	jikes? ( >=dev-java/jikes-1.21 )
	>=dev-java/ant-core-1.4"
RDEPEND=">=virtual/jdk-1.3"


src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/buildfile.patch
}

src_compile() {
	local antflags="build"
	if use doc; then
		antflags="${antflags} createdoc"
	fi
	if use jikes; then
		antflags="${antflags} -Dbuild.compiler=jikes"
	fi
	if use source; then
		antflags="${antflags} sourcezip"
	fi
	ant ${antflags} || die "failed to build"
}

src_install() {
	java-pkg_dojar dist/dtdparser.jar
	dodoc ASL_LICENSE CHANGES LICENSE LICENSE.INFO README

	if use doc; then
		java-pkg_dohtml -r doc/*
	fi
	if use source; then
		dodir /usr/share/doc/${PF}/source
		cp dist/${PN}-src.zip ${D}usr/share/doc/${PF}/source
	fi
}
