# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jai-bin/jai-bin-1.1.2-r2.ebuild,v 1.1 2004/07/30 20:07:34 axxo Exp $

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
	#Search for the ELF Header
	testExp=`echo -e "\177\105\114\106\001\001\001"`
	startAt=`grep -aonm 1 ${testExp}  ${DISTDIR}/${SRC_URI} | cut -d: -f1`
	tail -n +${startAt} ${DISTDIR}/${SRC_URI} > install.sfx
	chmod +x install.sfx
	./install.sfx || die
	rm install.sfx
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
			die "You must have a JVM selected in order to install JAI"
		fi
	fi
	einfo "Installing JAI into current JAVA home: ${java_home}"
	dodir ${java_home}/${jre}
	cp -a ${S}/jre/* ${D}/${java_home}/${jre}
	dodoc COPYRIGHT-jai.txt README-jai.txt
}
