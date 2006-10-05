# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jump/jump-0.4.1-r1.ebuild,v 1.10 2006/10/05 17:57:24 gustavoz Exp $

inherit java-pkg

DESCRIPTION="JUMP Ultimate Math Package (JUMP) is a Java-based extensible high-precision math package."
SRC_URI="mirror://sourceforge/${PN}-math/${P}.tar.gz"
HOMEPAGE="http://jump-math.sourceforge.net/"
KEYWORDS="x86 ~ppc amd64"
LICENSE="BSD"
SLOT="0"
DEPEND=">=virtual/jdk-1.2
		sys-apps/sed
		dev-java/ant-core"
RDEPEND=">=virtual/jre-1.2"
IUSE="doc"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:${java.home}/src::' -i build.xml || die
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} apidocs"
	ant ${antflags} || die "failed to build"
}

src_install() {
	java-pkg_dojar build/${PN}.jar
	use doc && java-pkg_dohtml -r ${S}/build/apidocs/*
}
