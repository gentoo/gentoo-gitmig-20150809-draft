# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/javahelp-bin/javahelp-bin-2.0.02-r1.ebuild,v 1.4 2007/07/11 19:58:37 mr_bones_ Exp $

inherit java-pkg

DESCRIPTION="JavaHelp software is a full-featured, platform-independent, extensible help system that enables you to incorporate online help in applets, components, applications, operating systems, and devices."
HOMEPAGE="http://java.sun.com/products/javahelp/"
SRC_URI="javahelp-${PV//./_}.zip"

LICENSE="sun-j2sl"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE="doc"

DEPEND=">=app-arch/unzip-5.50-r1"
RDEPEND=">=virtual/jre-1.3"
RESTRICT="fetch"

S="${WORKDIR}/jh2.0"

DOWNLOAD_URL="http://javashoplm.sun.com/ECom/docs/Welcome.jsp?StoreId=22&PartDetailId=javahelp-${PV//./_}-oth-JPR&SiteId=JSC&TransactionId=noreg"

pkg_nofetch() {
	einfo "Please download ${SRC_URI} from ${HOMEPAGE} and move it to ${DISTDIR}"
	einfo "Direct url: ${DOWNLOAD_URL}"
}

src_compile() { :; }

src_install(){
	java-pkg_dojar javahelp/lib/*.jar
	cp -R ${S}/javahelp/lib/dtd ${D}/usr/share/${PN}/lib
	cp -R ${S}/javahelp/bin ${D}/usr/share/${PN}/bin

	use doc && cp -R ${S}/demos ${D}/usr/share/${PN} && java-pkg_dohtml -r doc
	dodoc README
}
