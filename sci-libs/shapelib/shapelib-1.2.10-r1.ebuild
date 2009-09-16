# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/shapelib/shapelib-1.2.10-r1.ebuild,v 1.3 2009/09/16 04:58:05 nerdboy Exp $

inherit eutils toolchain-funcs

DESCRIPTION="library for manipulating ESRI Shapefiles"
HOMEPAGE="http://shapelib.maptools.org/"
SRC_URI="http://dl.maptools.org/dl/shapelib//${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/fix-shapelib-test.diff
	epatch "${FILESDIR}"/stdlib_include_fix.patch
	sed -i \
		-e 's:/usr/local/:${DESTDIR}/usr/:g' \
		-e "s:/usr/lib:/usr/$(get_libdir):g" \
		-e 's:SHPLIB_VERSION=1.2.9:SHPLIB_VERSION=1.2.10:g' \
		-e "s:-g:${CFLAGS}:g" \
		Makefile || die "sed failed"
}

src_compile() {
	emake || die "emake failed"
	emake lib || die "emake lib failed"
}

src_install() {
	dobin shp{create,dump,test,add} dbf{create,dump,add} \
		|| die "dobin failed"
	emake DESTDIR="${D}" lib_install || die "emake lib_install failed"
	dodoc ChangeLog || die
	dohtml *.html || die
}
