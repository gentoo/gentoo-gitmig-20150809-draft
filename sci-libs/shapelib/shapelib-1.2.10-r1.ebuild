# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/shapelib/shapelib-1.2.10-r1.ebuild,v 1.1 2006/02/20 00:41:08 nerdboy Exp $

inherit eutils toolchain-funcs

DESCRIPTION="library for manipulating ESRI Shapefiles"
HOMEPAGE="http://shapelib.maptools.org/"
SRC_URI="http://dl.maptools.org/dl/shapelib//${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND=""

export MY_LIBDIR=$(get_libdir)

src_unpack() {
	unpack ${A}
	cd ${S}
	sed \
	    -e 's:/usr/local/:${DESTDIR}/usr/:g' \
	    -e 's:/usr/lib:/usr/${MY_LIBDIR}:g' \
	    -e 's:SHPLIB_VERSION=1.2.9:SHPLIB_VERSION=1.2.10:g' \
	    -i Makefile || die
}

src_compile() {
	emake || die "emake failed"
	make lib || die "make lib failed"
}

src_install() {
	dobin shp{create,dump,test,add} dbf{create,dump,add} \
	    || die "dobin failed"
	make DESTDIR=${D} lib_install || die "lib_install failed"
}
