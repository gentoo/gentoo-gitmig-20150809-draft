# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/plplot/plplot-5.9.5.ebuild,v 1.2 2009/12/03 21:50:53 bicatali Exp $

EAPI="2"
WX_GTK_VER="2.8"
inherit eutils cmake-utils toolchain-funcs wxwidgets java-pkg-opt-2

DESCRIPTION="Multi-language scientific plotting library"
HOMEPAGE="http://plplot.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://gentoo/${P}-wxwidgets-cmake.patch.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ada cairo doc examples fortran gd gnome java jpeg latex octave
	 pdf perl png python qhull svg svga tcl threads tk truetype wxwidgets X"

RDEPEND="ada? ( virtual/gnat )
	cairo? ( x11-libs/cairo[svg?,X?] )
	java? ( >=virtual/jre-1.5 )
	gd? ( media-libs/gd[jpeg?,png?] )
	gnome? ( gnome-base/libgnomeui
			 gnome-base/libgnomeprintui
			 python? ( dev-python/gnome-python ) )
	latex? ( virtual/latex-base virtual/ghostscript )
	octave? ( >=sci-mathematics/octave-3 )
	pdf? ( media-libs/libharu )
	perl? ( dev-perl/PDL dev-perl/XML-DOM )
	python? ( dev-python/numpy )
	svga? ( media-libs/svgalib )
	tcl? ( dev-lang/tcl dev-tcltk/itcl )
	tk? ( dev-lang/tk dev-tcltk/itk )
	truetype? ( media-fonts/freefont-ttf
				media-libs/lasi
				gd? ( media-libs/gd[truetype] ) )
	wxwidgets? ( x11-libs/wxGTK:2.8[X] x11-libs/agg[truetype?] )
	X? ( x11-libs/libX11 x11-libs/libXau x11-libs/libXdmcp )"

DEPEND="${RDEPEND}
	>=dev-util/cmake-2.6
	dev-util/pkgconfig
	doc? ( app-text/opensp
		   app-text/jadetex
		   app-text/docbook2X
		   app-text/docbook-dsssl-stylesheets
		   dev-perl/XML-DOM
		   virtual/latex-base
		   virtual/ghostscript
		   sys-apps/texinfo )
	java? ( >=virtual/jdk-1.5 dev-lang/swig )
	python? ( dev-lang/swig )
	qhull? ( media-libs/qhull )"

pkg_setup() {
	if use fortran; then
		export FC=$(tc-getFC) F77=$(tc-getF77)
	else
		export FC="" F77=""
	fi
}

src_prepare() {
	# path for python independent of python version
	epatch "${FILESDIR}"/${PN}-5.9.0-python.patch

	# bug #242212
	epatch "${WORKDIR}"/${P}-wxwidgets-cmake.patch

	# remove license
	sed -i -e '/COPYING.LIB/d' CMakeLists.txt || die

	# change default install directories for doc and examples
	sed -i \
		-e 's:${DATA_DIR}/examples:${DOC_DIR}/examples:g' \
		examples/CMakeLists.txt examples/*/CMakeLists.txt || die
	sed -i \
		-e 's:${VERSION}::g' \
		-e "s:doc/\${PACKAGE}:doc/${PF}:" \
		cmake/modules/instdirs.cmake || die

	# haru pdf devide does not build with HPDF_SHARED
	sed -i \
		-e 's:-DHPDF_SHARED::' \
		cmake/modules/pdf.cmake || die

	# default location for docbook crap
	sed -i \
		-e 's:xml/declaration:sgml:' \
		cmake/modules/docbook.cmake || die
}

src_configure() {
	# see http://www.miscdebris.net/plplot_wiki/index.php?title=CMake_options_for_PLplot
	cmake-utils_pld() { _use_me_now PLD "$@" ; }

	mycmakeargs="
		-DUSE_RPATH=OFF
		-DDEFAULT_ALL_DEVICES=ON
		-DCMAKE_INSTALL_LIBDIR=/usr/$(get_libdir)
		$(cmake-utils_use_has python numpy)
		$(cmake-utils_use_has qhull QHULL)
		$(cmake-utils_use_has threads PTHREAD)
		$(cmake-utils_use_with truetype FREETYPE)
		$(cmake-utils_use_enable ada ada)
		$(cmake-utils_use_enable fortran f77)
		$(cmake-utils_use_enable java java)
		$(cmake-utils_use_enable gnome gnome2)
		$(cmake-utils_use_enable octave octave)
		$(cmake-utils_use_enable perl pdl)
		$(cmake-utils_use_enable python python)
		$(cmake-utils_use_enable tcl tcl)
		$(cmake-utils_use_enable tcl itcl)
		$(cmake-utils_use_enable tk tk)
		$(cmake-utils_use_enable tk itk)
		$(cmake-utils_pld wxwidgets _wxwidgets)
		$(cmake-utils_pld wxwidgets _wxpng)
		$(cmake-utils_pld pdf pdf)
		$(cmake-utils_pld truetype psttf)
		$(cmake-utils_pld latex pstex)
		$(cmake-utils_pld svga linuxvga)"

	use fortran && [[ $(tc-getFC) != g77 ]] && \
		mycmakeargs="${mycmakeargs} $(cmake-utils_use_enable fortran f95)"

	use truetype && mycmakeargs="${mycmakeargs}
		-DPL_FREETYPE_FONT_PATH:PATH=/usr/share/fonts/freefont-ttf"

	if use python && use gnome; then
		mycmakeargs="${mycmakeargs}	-DENABLE_pygcw=ON"
	else
		mycmakeargs="${mycmakeargs}	-DENABLE_pygcw=OFF"
	fi
	if use cairo; then
		# memcairo buggy, see cmake/modules/drivers-init.cmake
		mycmakeargs="${mycmakeargs}
			-DPLD_memcairo=OFF
			-DPLD_extcairo=OFF
			-DPLD_pdfcairo=ON
			-DPLD_pngcairo=ON
			-DPLD_pscairo=ON
			$(cmake-utils_pld svg svgcairo)
			$(cmake-utils_pld X xcairo)"
	else
		mycmakeargs="${mycmakeargs}
			-DPLD_memcairo=OFF
			-DPLD_extcairo=OFF
			-DPLD_pdfcairo=OFF
			-DPLD_pngcairo=OFF
			-DPLD_pscairo=OFF
			-DPLD_svgcairo=OFF
			-DPLD_xcairo=OFF"
	fi
	cmake-utils_src_configure
}

src_compile() {
	# separate doc and normal because doc building crashes with parallel
	cmake-utils_src_make
	if use doc; then
		mycmakeargs="${mycmakeargs}	-DBUILD_DOC=ON"
		mycmakeargs="${mycmakeargs}	-DHAVE_DB_DTD=ON"
		mycmakeargs="${mycmakeargs}	-DHAVE_DSSSL_DTD=ON"
		mycmakeargs="${mycmakeargs}	-DHAVE_HTML_SS=ON"
		mycmakeargs="${mycmakeargs}	-DHAVE_PRINT_SS=ON"
		cmake-utils_src_configure
		VARTEXFONTS="${T}/fonts" cmake-utils_src_make -j1
	fi
}

src_install() {
	cmake-utils_src_install
	use examples || rm -rf "${D}"usr/share/doc/${PF}/examples
}
