# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmng/libmng-1.0.3.ebuild,v 1.3 2002/07/16 11:36:48 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Multiple Image Networkgraphics lib (animated png's)"
SRC_URI="http://download.sourceforge.net/libmng/${P}.tar.gz"
HOMEPAGE="http://www.libmng.com/"

DEPEND=">=media-libs/jpeg-6b 
	>=sys-libs/zlib-1.1.3
	>=media-libs/lcms-1.0.8"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc"

src_unpack() {

	unpack ${A}
	cd ${S}
	cp libmng_types.h libmng_types.h.orig

	sed 's:\(#include\) "lcms.h":\1 <lcms/lcms.h>:' \
		libmng_types.h.orig > libmng_types.h
}

src_compile() {
	econf || die
	make || die
}

src_install () {
	make prefix=${D}/usr install || die
	dodoc Changes LICENSE README*
	dodoc doc/doc.readme doc/libmng.txt
	doman doc/man/*
	dohtml doc/*.png
}
