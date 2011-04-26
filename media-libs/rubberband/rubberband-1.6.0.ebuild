# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/rubberband/rubberband-1.6.0.ebuild,v 1.2 2011/04/26 06:52:08 radhermit Exp $

EAPI=4
inherit multilib eutils

DESCRIPTION="An audio time-stretching and pitch-shifting library and utility program"
HOMEPAGE="http://www.breakfastquay.com/rubberband/"
SRC_URI="http://code.breakfastquay.com/attachments/download/16/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="media-libs/vamp-plugin-sdk
	media-libs/libsamplerate
	media-libs/libsndfile
	media-libs/ladspa-sdk
	sci-libs/fftw:3.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc-4.6.patch
}

src_install() {
	emake INSTALL_BINDIR="${D}/usr/bin" \
		INSTALL_INCDIR="${D}/usr/include/rubberband" \
		INSTALL_LIBDIR="${D}/usr/$(get_libdir)" \
		INSTALL_VAMPDIR="${D}/usr/$(get_libdir)/vamp" \
		INSTALL_LADSPADIR="${D}/usr/$(get_libdir)/ladspa" \
		INSTALL_LRDFDIR="${D}/usr/share/ladspa/rdf" \
		INSTALL_PKGDIR="${D}/usr/$(get_libdir)/pkgconfig" \
		install

	dodoc CHANGELOG README.txt
}
