# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jgoodies-looks-bin/jgoodies-looks-bin-1.2.1-r2.ebuild,v 1.4 2004/10/22 11:06:33 absinthe Exp $

inherit java-pkg

DESCRIPTION="java look&feel from Karsten Lentzsch"
HOMEPAGE="http://www.jgoodies.com"
SRC_URI="http://www.jgoodies.com/download/libraries/looks-${PV//./_}.zip"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="doc"
DEPEND=">=virtual/jdk-1.4"
RDEPEND=">=virtual/jdk-1.4"
MY_P=${P/-bin}
MY_P=${MY_P/jgoodies-}
S=${WORKDIR}/${MY_P}

src_compile() { :; }

src_install() {
	java-pkg_dojar looks-${PV}.jar looks-win-${PV}.jar plastic-${PV}.jar
	dodoc README.html RELEASE-NOTES.txt
	use doc && java-pkg_dohtml -r docs/*
}
