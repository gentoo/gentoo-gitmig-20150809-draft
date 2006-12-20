# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/cdegroot-db/cdegroot-db-0.08-r1.ebuild,v 1.1 2006/12/20 23:15:58 betelgeuse Exp $

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="OO database written in Java"
HOMEPAGE="http://www.cdegroot.com/software/db/"
SRC_URI="http://www.cdegroot.com/software/db/download/com.${P/-/.}.tar.gz"

LICENSE="cdegroot"
SLOT="1"
KEYWORDS="amd64 x86 ppc64 ppc"
IUSE="doc source"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}/com.${P/-/.}

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -rf src/db/test

	cp ${FILESDIR}/build.xml ${S}/build.xml
	epatch ${FILESDIR}/${P}-gentoo.patch
}

EANT_DOC_TARGET="docs"

src_install() {
	java-pkg_dojar dist/${PN}.jar

	dodoc TODO VERSION CHANGES BUGS README
	use doc && java-pkg_dojavadoc docs
	use source && java-pkg_dosrc src/*
}
