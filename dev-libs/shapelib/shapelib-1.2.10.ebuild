# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/shapelib/shapelib-1.2.10.ebuild,v 1.6 2004/10/17 09:41:08 dholm Exp $

inherit eutils

DESCRIPTION="ShapeLib"
HOMEPAGE="http://gdal.velocet.ca/projects/shapelib/"
SRC_URI="ftp://gdal.velocet.ca/pub/outgoing//${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	emake || die
	make lib || die
}

src_install() {
	dobin shp{create,dump,test,add} dbf{create,dump,add} || die
	dolib.so .libs/libshp.so.1.0.1
	dosym libshp.so.1.0.1 usr/lib/libshp.so
	insinto /usr/include/libshp
	doins shapefil.h
}
