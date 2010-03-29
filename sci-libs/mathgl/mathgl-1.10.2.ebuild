# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/mathgl/mathgl-1.10.2.ebuild,v 1.1 2010/03/29 21:10:08 grozin Exp $

EAPI=2
WX_GTK_VER=2.8
inherit autotools wxwidgets python versionator toolchain-funcs

DESCRIPTION="Math Graphics Library"
HOMEPAGE="http://mathgl.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz mirror://sourceforge/${PN}/STIX_font.tgz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc fltk gif glut gsl hdf5 jpeg octave python qt4 wxwidgets"

RDEPEND="media-libs/libpng
	virtual/glu
	python? ( dev-python/numpy )
	glut? ( virtual/glut )
	fltk? ( x11-libs/fltk:1.1 )
	gif? ( media-libs/giflib )
	jpeg? ( media-libs/jpeg )
	hdf5? ( >=sci-libs/hdf5-1.8 )
	gsl? ( sci-libs/gsl )
	octave? ( sci-mathematics/octave )
	qt4? ( x11-libs/qt-gui:4 )
	wxwidgets? ( x11-libs/wxGTK:2.8 )"
DEPEND="${RDEPEND}
	>=sys-devel/libtool-2.2.4
	doc? ( app-text/texi2html virtual/texi2dvi )
	python? ( dev-lang/swig )
	octave? ( dev-lang/swig )"

pkg_setup() {
	if ! version_is_at_least "4.3.0" "$(gcc-version)"; then
		eerror "You need >=gcc-4.3.0 to compile this package"
		die "Wrong gcc version"
	fi
	if use hdf5 && has_version sci-libs/hdf5[mpi]; then
		export CC=mpicc
		export CXX=mpicxx
	fi
}

src_unpack() {
	unpack ${A}
	mkdir "${S}"/fonts
	cd "${S}"/fonts
	unpack STIX_font.tgz
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
		$(use_enable wxwidgets wx) \
		$(use_enable fltk) \
		$(use_enable gif) \
		$(use_enable jpeg) \
		$(use_enable hdf5 hdf5_18) \
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
