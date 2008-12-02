# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/mathgl/mathgl-1.8.ebuild,v 1.1 2008/12/02 16:23:04 grozin Exp $
EAPI=2
inherit flag-o-matic
DESCRIPTION="Math Graphics Library"
IUSE="doc fltk glut hdf5 jpeg python qt4 wxwindows"
# octave bindings don't work for me :-(
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
	qt4? ( x11-libs/qt-gui:4 )
	wxwindows? ( x11-libs/wxGTK:2.8 )"

DEPEND="${RDEPEND}
	doc? ( app-text/texi2html virtual/texi2dvi )
	python? ( dev-lang/swig[python] )"

src_configure() {
	# fltk example compiles only if we add
	use fltk && append-cppflags $(fltk-config --cflags)
	use fltk && append-ldflags $(fltk-config --ldflags)

	econf --docdir="${ROOT}"usr/share/doc/${P} \
		$(use_enable glut) \
		$(use_enable qt4 qt) \
		$(use_enable wxwindows wx) \
		$(use_enable fltk) \
		$(use_enable jpeg) \
		$(use_enable hdf5) \
		$(use_enable python) \
		$(use_enable doc docs)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README AUTHORS || die "dodoc failed"
}
