# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/javahelp-bin/javahelp-bin-2.0.01.ebuild,v 1.1 2004/07/30 20:28:57 axxo Exp $

inherit java-pkg

DESCRIPTION="JavaHelp software is a full-featured, platform-independent, extensible help system that enables you to incorporate online help in applets, components, applications, operating systems, and devices."
HOMEPAGE="http://java.sun.com/products/javahelp/"
LICENSE="sun-j2sl"
SLOT="0"
KEYWORDS="~x86 ~ppc"
DEPEND=">=app-arch/unzip-5.50-r1"
RDEPEND=">=virtual/jdk-1.3"
RESTRICT="fetch"
SRC_URI="javahelp-2_0_01.zip"
IUSE="doc"

S="${WORKDIR}/jh2.0"

pkg_nofetch() {
	einfo "Please download ${SRC_URI} from ${HOMEPAGE} and move it to ${DISTDIR}"
}

src_compile() { :; }

src_install(){
	java-pkg_dojar javahelp/lib/jh.jar
	cp -R ${S}/javahelp/lib ${D}/usr/share/${PN}
	cp -R ${S}/javahelp/bin ${D}/usr/share/${PN}/bin

	use doc && cp -R ${S}/demos ${D}/usr/share/${PN} && dohtml -r doc
	dodoc README
}

