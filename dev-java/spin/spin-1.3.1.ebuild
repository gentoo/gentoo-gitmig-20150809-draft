# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/spin/spin-1.3.1.ebuild,v 1.1 2004/12/03 21:31:32 rizzo Exp $

inherit java-pkg

DESCRIPTION="Spin is a transparent threading solution for non-freezing Swing applications."
HOMEPAGE="http://spin.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-java/ant"
#RDEPEND=""
S=${WORKDIR}

IUSE="doc"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:${java.home}/src::' -i build.xml
}

src_compile() {
	ant || die "failed to build"
}

src_install() {
	java-pkg_dojar dist/${PN}.jar
	use doc && java-pkg_dohtml -r ${S}/docs/api/*
}

