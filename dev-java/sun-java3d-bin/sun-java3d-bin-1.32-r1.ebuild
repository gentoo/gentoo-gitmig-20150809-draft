# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-java3d-bin/sun-java3d-bin-1.32-r1.ebuild,v 1.2 2004/07/31 16:29:47 axxo Exp $

inherit java-pkg

MY_P="java3d-1_3_2-build4-linux-i586"
DESCRIPTION="Sun Java3D"
HOMEPAGE="https://j3d-core.dev.java.net/"
SRC_URI="https://j3d-core.dev.java.net/files/documents/1674/5613/${MY_P}.tar.gz"
KEYWORDS="~x86 -*"
SLOT="0"
LICENSE="sun-jrl sun-jdl"
IUSE=""
DEPEND=""
RDEPEND=">=virtual/jdk-1.3"
RESTRICT="nomirror"

S=${WORKDIR}/${MY_P}

pkg_nofetch() {
	einfo "Please download ${SRC_URI} from ${HOMEPAGE} and place it in ${DISTDIR}"
}

src_unpack() {
	unpack ${A}
	cd ${S}
	jar xvf j3d-132-build4-linux-x86.jar
}
src_compile() { :; }

src_install() {
	dodoc COPYRIGHT.txt README.txt

	java-pkg_dojar lib/ext/*.jar
	java-pkg_doso lib/i386/*.so
}

pkg_postinst() {
	einfo "This ebuild now installs into /opt/${PN} and /usr/share/${PN}"
	einfo 'To use you need to pass the following to java'
	einfo '-Djava.library.path=$(java-config -i sun-java3d-bin) -cp $(java-config -p sun-java3d-bin)'
}
