# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jai/jai-1.1.2-r1.ebuild,v 1.1 2004/03/06 21:03:50 zx Exp $

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
	einfo "Installing JAI into current JDK home: `java-config --jdk-home`"
	start=${D}
	for e in `java-config --jdk-home | tr '/' ' '`; do
		start="$start/$e"
		mkdir $start
	done

	cd $start

	cp -a ${S}/jre/* .
	cd ${S}
	dodoc COPYRIGHT-jai.txt README-jai.txt
}
