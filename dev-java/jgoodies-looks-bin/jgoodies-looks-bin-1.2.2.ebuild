# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jgoodies-looks-bin/jgoodies-looks-bin-1.2.2.ebuild,v 1.2 2004/11/03 11:30:22 axxo Exp $

inherit java-pkg

DESCRIPTION="java look&feel from Karsten Lentzsch"
HOMEPAGE="http://www.jgoodies.com"
SRC_URI="http://www.jgoodies.com/download/libraries/looks-${PV//./_}.zip"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"
IUSE="doc"
DEPEND=">=virtual/jdk-1.4
		app-arch/unzip"
RDEPEND=">=virtual/jdk-1.4"
MY_P=${P/-bin}
MY_P=${MY_P/jgoodies-}
S=${WORKDIR}/${MY_P}

src_install() {
	mv looks-${PV}.jar ${PN}.jar
	java-pkg_dojar ${PN}.jar
	dodoc README.html RELEASE-NOTES.txt
	use doc && java-pkg_dohtml -r docs/*
}
