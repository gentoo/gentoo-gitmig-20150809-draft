# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/quickplot/quickplot-0.8.5.ebuild,v 1.2 2005/01/07 03:52:57 cryos Exp $

DESCRIPTION="A fast interactive 2D plotter."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://quickplot.sourceforge.net/"

IUSE="sndfile"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

RDEPEND=">=dev-cpp/gtkmm-2.4.5
	sndfile? ( >=media-libs/libsndfile-1.0.5 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.15"

src_compile() {
	econf `use_with sndfile libsndfile` || die "econf step failed."
	emake htmldir=/usr/share/doc/${PF}/html || die "emake step failed."
}

src_install () {
	make install DESTDIR=${D} htmldir=/usr/share/doc/${PF}/html \
		|| die "make install step failed."
	dodoc AUTHORS ChangeLog README README.devel TODO
	# Remove COPYING as it is specified in LICENCE. Move other stuff.
	cd ${D}/usr/share/doc/${PF}/html
	rm COPYING quickplot_icon.png ChangeLog
	mv ${D}/usr/share/pixmaps/quickplot_icon.png \
		${D}/usr/share/pixmaps/quickplot.png
}
