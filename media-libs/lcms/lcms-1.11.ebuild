# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/lcms/lcms-1.11.ebuild,v 1.2 2003/09/22 14:11:10 lanius Exp $

DESCRIPTION="A lightweight, speed optimized color management engine"
SRC_URI="http://www.littlecms.com/${P}.tar.gz"
HOMEPAGE="http://www.littlecms.com/"

DEPEND="tiff? ( media-libs/tiff )
	jpeg? ( media-libs/jpeg )
	zlib? ( sys-libs/zlib )
	python? ( dev-lang/python )"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"
IUSE="tiff jpeg"

src_compile() {
	use jpeg && myconf="${myconf} --with-jpeg" || myconf="${myconf} --without-jpeg"
	use tiff && myconf="${myconf} --with-tiff" || myconf="${myconf} --without-tiff"
	use zlib && myconf="${myconf} --with-zlib" || myconf="${myconf} --without-zlib"
	use python && myconf="${myconf} --with-python" || myconf="${myconf} --without-python"

	econf ${myconf} || die
	make || die
}

src_install () {

	make \
		DESTDIR=${D} \
		BINDIR=${D}/usr/bin \
		install || die

	dodir /usr/include/lcms
	mv ${D}/usr/include/*.h ${D}/usr/include/lcms

	cd ${S}/testbed
	dodir /usr/share/lcms/profiles
	cp *.icm ${D}/usr/share/lcms/profiles
	cd ${S}

	dodoc AUTHORS COPYING README* INSTALL NEWS
	docinto txt
	dodoc doc/*
}
