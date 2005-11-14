# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/shapelib/shapelib-1.2.10.ebuild,v 1.5 2005/11/14 05:14:04 vapier Exp $

DESCRIPTION="library for manipulating ESRI Shapefiles"
HOMEPAGE="http://shapelib.maptools.org/"
SRC_URI="http://dl.maptools.org/dl/shapelib//${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND=""

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
