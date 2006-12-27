# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/dtdparser/dtdparser-1.21-r1.ebuild,v 1.1 2006/12/27 22:45:52 betelgeuse Exp $

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="A Java DTD Parser"
HOMEPAGE="http://www.wutka.com/dtdparser.html"
SRC_URI="http://www.wutka.com/download/${P}.tgz"

LICENSE="LGPL-2.1 Apache-1.1"
SLOT="${PV}"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="doc source"

DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.4
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/buildfile.patch
}

EANT_BUILD_TARGET="build"
EANT_DOC_TARGET="createdoc"

src_install() {
	java-pkg_dojar dist/${PN}.jar
	dodoc CHANGES README

	use doc && java-pkg_dojavadoc doc
	use source && java-pkg_dosrc source/*
}
