# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jump/jump-0.4.1-r1.ebuild,v 1.5 2004/10/29 01:53:32 absinthe Exp $

inherit java-pkg

DESCRIPTION="JUMP Ultimate Math Package (JUMP) is a Java-based extensible high-precision math package."
SRC_URI="mirror://sourceforge/${PN}-math/${PN}-${PV}.tar.gz"
HOMEPAGE="http://jump-math.sourceforge.net/"
KEYWORDS="x86 ~ppc ~sparc ~amd64"
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
	sed -i 's:${java.home}/src::' -i build.xml
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
