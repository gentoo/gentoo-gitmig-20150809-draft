# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/javamake-bin/javamake-bin-1.3.2.ebuild,v 1.1 2005/03/18 01:07:44 compnerd Exp $

inherit java-pkg

DESCRIPTION="Java specific make tool"
HOMEPAGE="http://www.experimentalstuff.com/Technologies/JavaMake/"
SRC_URI="http://www.experimentalstuff.com/data/javamake${PV}.jar
		 doc? ( http://www.experimentalstuff.com/data/javamake-doc.zip )"

LICENSE="sun-asis-javamake"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

DEPEND=""
RDEPEND="virtual/jre
		 doc? ( app-arch/unzip )"

src_unpack() {
	mkdir -p ${S}
	cd ${S}

	cp ${DISTDIR}/javamake${PV}.jar javamake.jar
	use doc && unpack javamake-doc.zip
}

src_install() {
	java-pkg_dojar javamake.jar
	use doc && java-pkg_dohtml ${S}/*.html
}
