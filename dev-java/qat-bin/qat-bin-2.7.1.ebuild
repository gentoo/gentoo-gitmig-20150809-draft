# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/qat-bin/qat-bin-2.7.1.ebuild,v 1.1 2004/07/30 21:27:04 axxo Exp $

inherit java-pkg

DESCRIPTION="Quality Assurance Tester - A distributed test harnass."
SRC_URI="mirror://sourceforge/qat/qat-${PV}.zip"
HOMEPAGE="http://qat.sourceforge.net"
LICENSE="sun-csl"
SLOT="0"
KEYWORDS="~x86 ~sparc"
DEPEND=""
RDEPEND=">=virtual/jdk-1.3"
IUSE="doc"

src_compile() { :; }

src_install() {
	mv jar/${P/-bin}.jar ${PN/-bin}.jar
	java-pkg_dojar ${PN/-bin}.jar
	use doc && dohtml -r doc/* && dohtml -r specification/* && cp -R examples ${D}/usr/share/doc/${P/-bin}/
}

