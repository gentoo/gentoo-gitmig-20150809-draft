# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc2-stdext/jdbc2-stdext-2.0.ebuild,v 1.7 2004/10/20 11:32:45 absinthe Exp $

inherit java-pkg

DESCRIPTION="A standard set of libs for Server-Side JDBC support"
HOMEPAGE="http://java.sun.com/products/jdbc"
SRC_URI="jdbc2_0-stdext.jar"
LICENSE="sun-csl"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""
RESTRICT="fetch"

RDEPEND=">=virtual/jdk-1.4"

S=${WORKDIR}

pkg_nofetch() {
	einfo
	einfo " Due to license restrictions, we cannot fetch the"
	einfo " distributables automagically."
	einfo " "
	einfo " 1. Visit http://java.sun.com/products/jdbc/download.html#spec'"
	einfo " 2. Select 'JDBC(TM) 2.0 Optional Package Binary'"
	einfo " 3. Download ${SRC_URI}"
	einfo " 4. Move file to ${DISTDIR}"
	einfo " 5. Run emerge on this package again to complete"
	einfo
}

src_unpack() { :; }

src_compile() { :; }

src_install() {
	java-pkg_dojar ${DISTDIR}/${A}
}

