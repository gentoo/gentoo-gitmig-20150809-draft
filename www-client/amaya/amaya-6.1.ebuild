# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/amaya/amaya-6.1.ebuild,v 1.1 2005/03/15 14:35:22 seemant Exp $

S=${WORKDIR}/Amaya/LINUX-ELF
DESCRIPTION="The W3C Web-Browser"
SRC_URI="ftp://ftp.w3.org/pub/amaya/${PN}-src-${PV}.tgz
	 ftp://ftp.w3.org/pub/amaya/old/${PN}-src-${PV}.tgz"
HOMEPAGE="http://www.w3.org/Amaya/"
KEYWORDS="x86 ppc sparc"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="x11-libs/openmotif"
DEPEND="dev-lang/perl
	${RDEPEND}"

src_compile() {

	mkdir ${S}
	cd ${S}

	../configure --prefix=/usr --host=${CHOST} || die
	make || die

}

src_install () {

	dodir /usr
	make prefix=${D}/usr install || die
	rm ${D}/usr/bin/amaya
	rm ${D}/usr/bin/print
	dosym /usr/Amaya/applis/bin/amaya /usr/bin/amaya
	dosym /usr/Amaya/applis/bin/print /usr/bin/print

}

