# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/shapelib/shapelib-1.2.10.ebuild,v 1.2 2005/03/10 20:39:01 phosphan Exp $

inherit eutils

DESCRIPTION="ShapeLib"
HOMEPAGE="http:///shapelib.maptools.org/"
SRC_URI="http://dl.maptools.org/dl/shapelib//${P}.tar.gz"

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
