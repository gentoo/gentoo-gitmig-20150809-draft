# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-java3d-bin/sun-java3d-bin-1.32.ebuild,v 1.1 2004/07/31 14:17:50 axxo Exp $

MY_P="java3d-1_3_2-build4-linux-i586"
DESCRIPTION="Sun Java3D"
HOMEPAGE="https://j3d-core.dev.java.net/"
SRC_URI="https://j3d-core.dev.java.net/files/documents/1674/5613/${MY_P}.tar.gz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="sun-jrl sun-jdl"
IUSE=""
DEPEND=">=virtual/jdk-1.3
	dev-java/java-config"
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

src_install() {
	start=${D}
	jre=""
	java_home="$(java-config --jdk-home)"
	if [ ! -z "${java_home}" ]; then
		jre="jre/"
	else
		java_home="$(java-config --jre-home)"
		if [ -z ${java_home} ]; then
			die "You must have a JVM selected in order to install Java3d"
		fi
	fi
	einfo "Installing Java3D into current JAVA home: ${java_home}"
	dodir ${java_home}/${jre}
	cp -a lib ${D}/${java_home}/${jre}
	dodoc COPYRIGHT.txt README.txt
}
