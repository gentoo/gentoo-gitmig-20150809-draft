# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/cvslib-bin/cvslib-bin-3.5.ebuild,v 1.1 2004/09/17 09:28:51 axxo Exp $

inherit java-pkg

DESCRIPTION="The cvs client library jar containing the stable version as in Netbeans 3.6 release."

HOMEPAGE="http://javacvs.netbeans.org/"
SRC_URI="http://www.netbeans.org/files/51/52/cvslib.jar
	doc? ( http://www.netbeans.org/files/51/52/javadoc_stable.zip )"
LICENSE="SPL"
SLOT="3.5"
KEYWORDS="~x86 ~ppc"
IUSE="doc"
DEPEND="app-arch/unzip"

S=${WORKDIR}

src_unpack() {
	cd ${S}
	cp ${DISTDIR}/cvslib.jar ${WORKDIR}
	use doc && unzip ${DISTDIR}/javadoc_stable.zip
}

src_compile() { :; }

src_install() {
	java-pkg_dojar cvslib.jar
	use doc && dohtml -r javadoc/
}
