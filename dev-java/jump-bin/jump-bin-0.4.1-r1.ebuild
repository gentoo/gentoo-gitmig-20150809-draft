# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jump-bin/jump-bin-0.4.1-r1.ebuild,v 1.1 2004/08/21 11:44:31 axxo Exp $

inherit java-pkg

DESCRIPTION="JUMP Ultimate Math Package (JUMP) is a Java-based extensible high-precision math package."
MY_P=${P/-bin}
SRC_URI="mirror://sourceforge/${PN/-bin}-math/${MY_P}-bin.tar.gz"
HOMEPAGE="http://jump-math.sourceforge.net/"
KEYWORDS="x86 ~ppc ~sparc"
LICENSE="BSD"
SLOT="0"
DEPEND=""
RDEPEND=">=virtual/jdk-1.2"
IUSE="doc"
S=${WORKDIR}/${MY_P}

src_compile() { :; }

src_install() {
	use doc && dohtml -r ${S}/build/apidocs/*
	java-pkg_dojar build/jump.jar
}
