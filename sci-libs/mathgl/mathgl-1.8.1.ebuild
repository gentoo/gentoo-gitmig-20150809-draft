# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/mathgl/mathgl-1.8.1.ebuild,v 1.2 2009/04/24 19:08:19 grozin Exp $
EAPI=2
WX_GTK_VER=2.8
inherit autotools wxwidgets python versionator toolchain-funcs
DESCRIPTION="Math Graphics Library"
IUSE="doc fltk gif glut gsl hdf5 jpeg octave python qt4 wxwindows"
HOMEPAGE="http://mathgl.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

RDEPEND="media-libs/libpng
	virtual/glu
	python? ( dev-python/numpy )
	glut? ( virtual/glut )
	fltk? ( x11-libs/fltk:1.1 )
	gif? ( media-libs/giflib )
	jpeg? ( media-libs/jpeg )
	hdf5? ( sci-libs/hdf5 )
	gsl? ( sci-libs/gsl )
	octave? ( sci-mathematics/octave )
	qt4? ( x11-libs/qt-gui:4 )
	wxwindows? ( x11-libs/wxGTK:2.8 )"

DEPEND="${RDEPEND}
	doc? ( app-text/texi2html virtual/texi2dvi )
	python? ( dev-lang/swig )
	octave? ( dev-lang/swig )"

pkg_setup() {
	if ! version_is_at_least "4.3.0" "$(gcc-version)"; then
		eerror "You need >=gcc-4.3.0 to compile this package"
		die "Wrong gcc version"
	fi
}

src_prepare() {
	# bug #267061
	epatch "${FILESDIR}"/${P}-gcc43.patch

	# correct location of numpy/arrayobject.h
	if use python; then
		local numpy_h
		numpy_h=$(python_get_sitedir)/numpy/core/include/numpy/arrayobject.h
		einfo "fixing numpy.i"
		sed -e "s|<numpy/arrayobject.h>|\"${numpy_h}\"|" \
			-i lang/numpy.i \
			|| die "sed failed"
	fi

	eautoreconf
}

src_configure() {
	econf --docdir="${ROOT}"usr/share/doc/${PF} \
		$(use_enable glut) \
		$(use_enable qt4 qt) \
		$(use_enable wxwindows wx) \
		$(use_enable fltk) \
		$(use_enable gif) \
		$(use_enable jpeg) \
		$(use_enable hdf5) \
		$(use_enable python) \
		$(use_enable octave) \
		$(use_enable gsl) \
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

pkg_postinst() {
	if use octave; then
		octave <<-EOF
		pkg install /usr/share/${PN}/octave/${PN}.tar.gz
		EOF
	fi
}

pkg_prerm() {
	if use octave; then
		octave <<-EOF
		pkg uninstall ${PN}
		EOF
	fi
}
