# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jai-bin/jai-bin-1.1.2.01.ebuild,v 1.1 2004/10/17 10:42:08 axxo Exp $

inherit java-pkg

DESCRIPTION="JAI is a class library for managing images."
HOMEPAGE="http://java.sun.com/products/java-media/jai/"
SRC_URI="jai-${PV//./_}-lib-linux-i586.tar.gz"
LICENSE="sun-bcla-jai"
SLOT="0"
KEYWORDS="~x86 ~sparc"
DEPEND="app-arch/unzip"
RDEPEND=">=virtual/jdk-1.3"
IUSE=""
RESTRICT="fetch"

S=${WORKDIR}/jai-${PV//./_}/

pkg_nofetch() {
	einfo "Please download ${SRC_URI} from ${HOMEPAGE} and place it in ${DISTDIR}"
}

src_compile() { :; }

src_install() {
	dodoc *.txt

	cd lib
	java-pkg_dojar *.jar
	use x86 && java-pkg_doso *.so
}

pkg_postinst() {
	einfo "This ebuild now installs into /opt/${PN} and /usr/share/${PN}"
	einfo 'To use you need to pass the following to java'
	use x86 && einfo '-Djava.library.path=$(java-config -i jai-bin)'
	einfo '-classpath $(java-config -p jai-bin)'
}

