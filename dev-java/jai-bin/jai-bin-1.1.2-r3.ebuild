# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jai-bin/jai-bin-1.1.2-r3.ebuild,v 1.2 2004/07/31 16:27:01 axxo Exp $

inherit java-pkg

DESCRIPTION="JAI is a class library for managing images."
HOMEPAGE="http://java.sun.com/products/java-media/jai/"
SRC_URI="jai-1_1_2-lib-linux-i586-jdk.bin"
LICENSE="sun-bcla-jai"
SLOT="0"
KEYWORDS="~x86 ~sparc ~alpha"
DEPEND=""
RDEPEND=">=virtual/jdk-1.3"
IUSE=""
RESTRICT="fetch"

S="${WORKDIR}"
pkg_nofetch() {
	einfo "Please download ${SRC_URI} from ${HOMEPAGE} and place it in ${DISTDIR}"
}

src_unpack() {
	unzip ${DISTDIR}/${SRC_URI}
}
src_compile() { :; }

src_install() {
	dodoc COPYRIGHT-jai.txt README-jai.txt

	java-pkg_dojar jre/lib/ext/*.jar
	java-pkg_doso jre/lib/i386/*.so
}

pkg_postinst() {
	einfo "This ebuild now installs into /opt/${PN} and /usr/share/${PN}"
	einfo 'To use you need to pass the following to java'
	einfo '-Djava.library.path=$(java-config -i jai-bin) -cp $(java-config -p jai-bin)'
}

