# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/quickplot/quickplot-0.8.2.ebuild,v 1.1 2005/01/05 01:12:43 cryos Exp $

inherit eutils

DESCRIPTION="A fast interactive 2D plotter."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://quickplot.sourceforge.net/"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

DEPEND=">=dev-util/pkgconfig-0.15
	>=dev-cpp/gtkmm-2.4.5
	>=media-libs/libsndfile-1.0.5"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gcc-3.4.patch
}

src_compile() {
	econf || die "econf step failed."
	emake || die "emake step failed."
}

src_install () {
	make install DESTDIR=${D} || die "make install step failed."
}
