# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/lcms/lcms-1.09.ebuild,v 1.13 2004/03/19 07:56:04 mr_bones_ Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A lightweight, speed optimized color management engine"
SRC_URI="http://www.littlecms.com/${P}.tar.gz"
HOMEPAGE="http://www.littlecms.com/"

DEPEND="media-libs/tiff
	media-libs/jpeg
	sys-libs/zlib"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ppc sparc alpha hppa amd64"

src_compile() {
	mv ${S}/src/makefile ${S}/src/makefile.orig
	sed -e 's/-Wall/-Wall -fPIC/' ${S}/src/makefile.orig > ${S}/src/makefile
	make || die

}

src_install () {

	make \
		DESTDIR=${D} \
		BINDIR=${D}/usr/bin \
		install || die

	( use tiff && use jpeg ) && ( \
	make \
		DESTDIR=${D} \
		utils || die
	)

	cd ${D}/usr/include
	cp lcms.h lcms.orig
	sed -e "s:#define VERSION.*::" \
		-e "s:#define PACKAGE.*::" \
		lcms.orig > lcms.h
	rm lcms.orig

	dodir /usr/include/lcms
	mv ${D}/usr/include/*.h ${D}/usr/include/lcms

	cd ${S}/testbed
	dodir /usr/share/lcms/profiles
	cp *.icm ${D}/usr/share/lcms/profiles
	cd ${S}

	dodoc AUTHORS COPYING ChangeLog README* INSTALL NEWS README
	docinto txt
	dodoc doc/*

}
