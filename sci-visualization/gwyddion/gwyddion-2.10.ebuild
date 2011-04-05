# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/gwyddion/gwyddion-2.10.ebuild,v 1.7 2011/04/05 05:36:05 ulm Exp $

EAPI="1"

DESCRIPTION="A software framework for SPM data analysis"
HOMEPAGE="http://gwyddion.net/"
SRC_URI="http://gwyddion.net/download/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="python perl ruby nls tiff fftw"

RDEPEND="
	virtual/opengl
	python? ( dev-lang/python )
	perl? ( dev-lang/perl )
	ruby? ( =dev-lang/ruby-1.8* )
	tiff? ( media-libs/tiff )
	fftw? ( >=sci-libs/fftw-3 )
	x11-libs/gtk+:2
	x11-libs/pango
	x11-libs/cairo
	x11-libs/gtkglext"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf \
		$(use_enable python) \
		$(use_enable perl) \
		$(use_enable ruby) \
		$(use_enable nls) \
		$(use_with fftw fftw3) \
		$(use_with tiff) \
		--disable-pascal \
		--disable-desktop-file-update \
		--enable-library-bloat
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
