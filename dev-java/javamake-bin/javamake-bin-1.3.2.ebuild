# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/javamake-bin/javamake-bin-1.3.2.ebuild,v 1.5 2005/07/16 10:44:15 axxo Exp $

inherit java-pkg

DESCRIPTION="Java specific make tool"
HOMEPAGE="http://www.experimentalstuff.com/Technologies/JavaMake/"
SRC_URI="http://www.experimentalstuff.com/data/javamake${PV}.jar
		 doc? ( http://www.experimentalstuff.com/data/javamake-doc.zip )"

LICENSE="sun-asis-javamake"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"
IUSE="doc"

DEPEND="doc? ( app-arch/unzip )"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}
src_unpack() {
	cp ${DISTDIR}/javamake${PV}.jar javamake.jar
	use doc && unpack javamake-doc.zip
}

src_install() {
	java-pkg_dojar javamake.jar
	use doc && java-pkg_dohtml ${S}/*.html
}
