# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc2-stdext/jdbc2-stdext-2.0-r1.ebuild,v 1.10 2007/07/11 19:58:38 mr_bones_ Exp $

inherit java-pkg

stdext_bin="jdbc2_0-stdext.jar"
stdext_doc="jdbc2_0_1-stdext-javadoc.zip"

DESCRIPTION="A standard set of libs for Server-Side JDBC support"
HOMEPAGE="http://java.sun.com/products/jdbc"
SRC_URI="${stdext_bin} doc? ( ${stdext_doc} )"
LICENSE="sun-csl"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE="doc"
RESTRICT="fetch"
DEPEND="app-arch/unzip"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}

pkg_nofetch() {
	einfo
	einfo " Due to license restrictions, we cannot fetch the"
	einfo " distributables automagically."
	einfo
	einfo " 1. Visit http://java.sun.com/products/jdbc/download.html#spec'"
	einfo " 2. Select 'JDBC(TM) 2.0 Optional Package Binary'"
	einfo " 3. Download ${stdext_bin}"
	einfo " 4. Move to ${DISTDIR}"
	use doc && einfo " 5. Select 'JDBC(TM) 2.0 Optional Package Documentation'"
	use doc && einfo " 6. Download ${stdext_doc}"
	use doc && einfo " 7. Move to ${DISTDIR}"
	einfo
	einfo " Run emerge on this package again to complete"
	einfo
}

src_unpack() {
	if use doc; then
		cd ${S}
		unzip ${DISTDIR}/${stdext_doc} || die "failed too build"
	fi
}

src_compile() { :; }

src_install() {
	if use doc; then
		java-pkg_dohtml -r ${S}/html/
	fi
	java-pkg_dojar ${DISTDIR}/${stdext_bin}
}
