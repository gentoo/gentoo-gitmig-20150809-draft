# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/mathgl/mathgl-1.8-r1.ebuild,v 1.1 2008/12/06 16:26:11 grozin Exp $
EAPI=2
WX_GTK_VER=2.8
inherit autotools wxwidgets
DESCRIPTION="Math Graphics Library"
IUSE="doc fltk glut hdf5 jpeg octave python qt4 wxwindows"
HOMEPAGE="http://mathgl.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

RDEPEND="sci-libs/gsl
	media-libs/libpng
	virtual/glu
	glut? ( virtual/glut )
	fltk? ( x11-libs/fltk )
	jpeg? ( media-libs/jpeg )
	hdf5? ( sci-libs/hdf5 )
	octave? ( sci-mathematics/octave )
	qt4? ( x11-libs/qt-gui:4 )
	wxwindows? ( x11-libs/wxGTK:2.8 )"

DEPEND="${RDEPEND}
	doc? ( app-text/texi2html virtual/texi2dvi )
	python? ( dev-lang/swig[python] )
	octave? ( dev-lang/swig[octave] )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-octave.patch
	epatch "${FILESDIR}"/${P}-fltk.patch
	eautoreconf
}

src_configure() {
	econf --docdir="${ROOT}"usr/share/doc/${PF} \
		$(use_enable glut) \
		$(use_enable qt4 qt) \
		$(use_enable wxwindows wx) \
		$(use_enable fltk) \
		$(use_enable jpeg) \
		$(use_enable hdf5) \
		$(use_enable python) \
		$(use_enable octave) \
		$(use_enable doc docs)
}

src_compile() {
	# see bug #249627
	local JOBS
	use doc && JOBS=-j1
	emake ${JOBS} || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README AUTHORS || die "dodoc failed"
}
