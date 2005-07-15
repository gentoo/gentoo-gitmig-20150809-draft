# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jump/jump-0.4.1-r1.ebuild,v 1.7 2005/07/15 21:16:15 axxo Exp $

inherit java-pkg

DESCRIPTION="JUMP Ultimate Math Package (JUMP) is a Java-based extensible high-precision math package."
SRC_URI="mirror://sourceforge/${PN}-math/${}.tar.gz"
HOMEPAGE="http://jump-math.sourceforge.net/"
KEYWORDS="x86 ~ppc ~sparc amd64"
LICENSE="BSD"
SLOT="0"
DEPEND=">=virtual/jdk-1.2
		sys-apps/sed
		dev-java/ant"
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
