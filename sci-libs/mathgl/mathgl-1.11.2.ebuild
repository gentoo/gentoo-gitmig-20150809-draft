# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/mathgl/mathgl-1.11.2.ebuild,v 1.2 2011/08/09 08:49:44 ssuominen Exp $

EAPI=3

WX_GTK_VER=2.8
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit autotools eutils wxwidgets python versionator toolchain-funcs

DESCRIPTION="Math Graphics Library"
HOMEPAGE="http://mathgl.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz mirror://sourceforge/${PN}/STIX_font.tgz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc fltk gif glut gsl hdf5 jpeg octave python qt4 wxwidgets"

RDEPEND="media-libs/libpng
	sys-libs/zlib
	virtual/opengl
	python? ( dev-python/numpy )
	glut? ( media-libs/freeglut )
	fltk? ( x11-libs/fltk:1 )
	gif? ( media-libs/giflib )
	jpeg? ( virtual/jpeg )
	hdf5? ( >=sci-libs/hdf5-1.8 )
	gsl? ( sci-libs/gsl )
	octave? ( >=sci-mathematics/octave-3.4.0 )
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
	use python && python_pkg_setup
	use wxwidgets && wxwidgets_pkg_setup
}

src_unpack() {
	unpack ${A}
	mkdir "${S}"/fonts
	cd "${S}"/fonts
	unpack STIX_font.tgz
}

src_prepare() {
	# bug #267061
	epatch "${FILESDIR}"/${PN}-1.10.2-gcc43.patch

	# bug #358245
	epatch "${FILESDIR}"/${PN}-octave-3.4.patch

	# bug #378255
	epatch "${FILESDIR}"/${PN}-1.11.2-zlib.patch

	# correct location of numpy/arrayobject.h
	if use python; then
		sed \
			-e '/SUBDIRS/s:lang::g' \
			-i Makefile.am || die
	fi

	echo "#!${EPREFIX}/bin/sh" > config/py-compile

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

	if use python; then
		python_copy_sources lang
		compilation() {
			local numpy_h
			numpy_h=$(python_get_sitedir)/numpy/core/include/numpy/arrayobject.h
			einfo "fixing numpy.i for Python-${PYTHON_ABI}"
			sed -e "s|<numpy/arrayobject.h>|\"${numpy_h}\"|" \
				-i numpy.i \
				|| die "sed failed"
			emake PYTHON_HEADERS="-I$(python_get_includedir)" pyexecdir="$(python_get_sitedir)"
		}
		python_execute_function -s --source-dir lang compilation
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	if use python; then
		installation() {
			emake DESTDIR="${D}" PYTHON="$(PYTHON)" pyexecdir="$(python_get_sitedir)" pythondir="$(python_get_sitedir)" install
		}
		python_execute_function -s --source-dir lang installation
		python_clean_installation_image
	fi
	dodoc README AUTHORS || die "dodoc failed"
}

pkg_postinst() {
	if use octave; then
		octave <<-EOF
		pkg install /usr/share/${PN}/octave/${PN}.tar.gz
		EOF
	fi
	use python && python_mod_optimize ${PN}.py
}

pkg_prerm() {
	if use octave; then
		octave <<-EOF
		pkg uninstall ${PN}
		EOF
	fi
}

pkg_postrm() {
	use python && python_mod_cleanup ${PN}.py
}
