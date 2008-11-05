# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/funtools/funtools-1.4.0.ebuild,v 1.1 2008/11/05 22:13:59 bicatali Exp $

EAPI=2
inherit eutils

DESCRIPTION="FITS library and utlities for astronomical images"
HOMEPAGE="http://hea-www.harvard.edu/RD/funtools/"
SRC_URI="http://hea-www.harvard.edu/saord/download/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="sys-libs/zlib
	>=sci-astronomy/wcstools-3.7.6
	sci-visualization/gnuplot"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-ds9-5.4.patch
	epatch "${FILESDIR}"/${P}-makefiles.patch
}

src_configure() {
	econf \
		--enable-shared \
		--enable-dl \
		--enable-mainlib \
		--with-wcslib="$(pkg-config --libs wcstools)" \
		--with-zlib=-lz \
		--with-tcl=-ltcl \
		WCS_INC="$(pkg-config --cflags wcstools)"
}

src_compile() {
	emake || die "emake failed"
	emake shtclfun || die "emake tcl functions failed"
}

src_install () {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	# install missing includes
	insinto /usr/include/funtools/fitsy
	doins fitsy/*.h || die
	if use doc; then
		cd doc
		insinto /usr/share/doc/${PF}
		doins *.pdf || die
		insinto /usr/share/doc/${PF}/html
		doins *.html *.c || die
	fi
}
