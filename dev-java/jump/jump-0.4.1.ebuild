# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jump/jump-0.4.1.ebuild,v 1.6 2004/07/14 02:32:49 agriffis Exp $

inherit java-pkg

DESCRIPTION="JUMP Ultimate Math Package (JUMP) is a Java-based extensible high-precision math package."
SRC_URI="mirror://sourceforge/${PN}-math/${P}-bin.tar.gz"
HOMEPAGE="http://jump-math.sourceforge.net/"
KEYWORDS="x86 ~ppc ~sparc"
LICENSE="BSD"
SLOT="0"
DEPEND=""
RDEPEND=">=virtual/jdk-1.2"
IUSE="doc"


src_compile() { :; }

src_install() {
	use doc && dohtml -r ${S}/build/apidocs/*
	java-pkg_dojar build/jump.jar
}
