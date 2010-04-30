# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/grass/grass-6.4.0_rc6.ebuild,v 1.2 2010/04/30 08:54:30 scarabeus Exp $

EAPI="3"

PYTHON_DEPEND="python? 2"
inherit eutils python gnome2 versionator wxwidgets base

MY_PM=${PN}$(get_version_component_range 1-2 ${PV})
MY_P=${P/_rc/RC}

DESCRIPTION="A free GIS with raster and vector functionality, as well as 3D vizualization."
HOMEPAGE="http://grass.osgeo.org//"
SRC_URI="http://grass.osgeo.org/${MY_PM/.}/source/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="6"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

IUSE="X cairo cxx ffmpeg fftw gmath jpeg largefile motif mysql nls odbc opengl png postgres python readline sqlite tiff truetype wxwidgets"

TCL_DEPS="
	>=dev-lang/tcl-8.5
	>=dev-lang/tk-8.5
"

RDEPEND="
	sci-libs/gdal
	sci-libs/proj
	sys-libs/gdbm
	sys-libs/ncurses
	sys-libs/zlib
	cairo? ( x11-libs/cairo[X?,opengl?] )
	ffmpeg? ( media-video/ffmpeg )
	fftw? ( sci-libs/fftw:3.0 )
	gmath? (
		virtual/blas
		virtual/lapack
	)
	jpeg? ( media-libs/jpeg )
	motif? ( x11-libs/openmotif )
	mysql? ( dev-db/mysql )
	odbc? ( dev-db/unixODBC )
	png? ( media-libs/libpng )
	postgres? (
		|| (
			>=virtual/postgresql-base-8.4
			>=virtual/postgresql-server-8.4
		)
	)
	readline? ( sys-libs/readline )
	sqlite? ( dev-db/sqlite:3 )
	tiff? ( media-libs/tiff )
	truetype? ( media-libs/freetype:2 )
	X? (
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libX11
		x11-libs/libXaw
		x11-libs/libXext
		x11-libs/libXmu
		x11-libs/libXp
		x11-libs/libXpm
		x11-libs/libXt
		opengl? (
			virtual/opengl
			${TCL_DEPS}
		)
		python? ( wxwidgets? ( >=dev-python/wxpython-2.8.10.1 ) )
		!python? ( ${TCL_DEPS} )
		!wxwidgets? ( ${TCL_DEPS} )
	)
"

DEPEND="${RDEPEND}
	sys-devel/flex
	sys-devel/bison
	X? (
		x11-proto/xextproto
		x11-proto/xproto
		python? ( wxwidgets? ( dev-lang/swig ) )
	)"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	local myblas

	# check correct gmath profiles (this must sadly die)
	if use gmath; then
		for d in $(eselect lapack show); do myblas=${d}; done
		if [[ -z "${myblas/reference/}" ]] && [[ -z "${myblas/atlas/}" ]]; then
			ewarn "You need to set lapack to atlas or reference. Do:"
			ewarn "   eselect lapack set <impl>"
			ewarn "where <impl> is atlas, threaded-atlas or reference"
			die "setup failed"
		fi
		for d in $(eselect blas show); do myblas=${d}; done
		if [[ -z "${myblas/reference/}" ]] && [[ -z "${myblas/atlas/}" ]]; then
			ewarn "You need to set blas to atlas or reference. Do:"
			ewarn "   eselect blas set <impl>"
			ewarn "where <impl> is atlas, threaded-atlas or reference"
			die "setup failed"
		fi
	fi

	# check useflag nesting.
	use opengl && ! use X && ewarn "For opengl support X useflag must be enabled"
	use wxwidgets && ! use X && ewarn "For wxwidgets support X useflag must be enabled"
	use wxwidgets && ! use python && ewarn "For wxwidgets support python useflag must be enabled"

	# only py2 is supported
	python_set_active_version 2
}

src_prepare() {
	if ! use opengl; then
	    epatch "${FILESDIR}"/${PN}-6.4.0-html-nonviz.patch
	fi

	base_src_prepare
}

src_configure() {
	local myconf TCL_LIBDIR

	if use X; then
		TCL_LIBDIR="/usr/$(get_libdir)/tcl8.5"
		myconf+="
			--with-tcltk-libs=${TCL_LIBDIR}
			$(use_with opengl)
			--with-x
		"
		use opengl && myconf+=" --with-tcltk"

		if use python && use wxwidgets; then
			WX_BUILD=yes
			WX_GTK_VER=2.8
			need-wxwidgets base
			myconf+="
				--without-tcltk
				--with-wxwidgets=${WX_CONFIG}
			"
		else
			WX_BUILD=no
			# use tcl gui if wxwidgets are disabled
			
			myconf+="
				--with-tcltk
				--without-wxwidgets
			"
		fi
	else
		myconf+="
			--without-opengl
			--without-tcltk
			--without-wxwidgets
			--without-x
		"
	fi

	econf \
		--with-gdal=$(type -P gdal-config) \
		--with-curses \
		--with-proj \
		--with-proj-share="/usr/share/proj/" \
		--without-glw \
		--enable-shared \
		$(use_enable amd64 64bit) \
		$(use_with cairo) \
		$(use_with cxx) \
		$(use_with fftw) \
		$(use_with ffmpeg) \
		--with-ffmpeg-includes="/usr/include/libavcodec \
			/usr/include/libavdevice /usr/include/libavfilter \
			/usr/include/libavformat /usr/include/libavutil \
			/usr/include/libpostproc /usr/include/libswscale" \
		$(use_with gmath blas) \
		$(use_with gmath lapack) \
		$(use_with jpeg) \
		$(use_enable largefile) \
		$(use_with motif) \
		$(use_with mysql) \
		$(use_with nls) \
		$(use_with odbc) \
		$(use_with png) \
		$(use_with postgres) \
		$(use_with python) \
		$(use_with readline) \
		$(use_with sqlite) \
		$(use_with tiff) \
		$(use_with truetype freetype) \
		--with-freetype-includes="/usr/include/freetype2/" \
		${myconf}
}

src_compile() {
	# we don't want to link against embeded mysql lib
	base_src_compile MYSQLDLIB=""
}

src_install() {
	emake DESTDIR="${D}" \
		INST_DIR="${D}"/usr/share/${PN}/$(get_version_component_range 1-2 ${PV})/ \
		PREFIX="${D}"/usr/share/${PN}/$(get_version_component_range 1-2 ${PV})/ \
		BINDIR="${D}"/usr/bin \
		install || die

	cd "${D}"/usr/share/${PN}/$(get_version_component_range 1-2 ${PV})/
	# fix docs
	dodoc AUTHORS CHANGES || die
	dohtml -r docs/html/* || die
	rm -rf docs/ || die
	rm -rf {AUTHORS,CHANGES,COPYING,GPL.TXT,REQUIREMENTS.html} || die

	# manuals
	dodir /usr/share/man/man1 || die
	mv man/man1/* "${D}"/usr/share/man/man1/ || die
	rm -rf man/ || die

	# translations
	dodir /usr/share/locale/ || die
	mv locale/* "${D}"/usr/share/locale/ || die
	rm -rf locale/ || die

	# get rid of DESTDIR in script path
	sed -i -e "s:${D}:/:" "${D}"usr/bin/${MY_PM/.} || die

	cd ${S}
	if use X; then
		generate_files
		doicon gui/icons/${PN}-48x48.png || die
		domenu ${MY_PM/.}-grass.desktop || die
	fi

	# FIXME: install .pc file so other apps know where to look for grass
}

pkg_postinst() {
	if use X; then
		fdo-mime_desktop_database_update
		gnome2_icon_cache_update
	fi
}

pkg_postrm() {
	if use X; then
		fdo-mime_desktop_database_update
		gnome2_icon_cache_update
	fi
}

generate_files() {
	local GUI="-gui"
	[[ ${WX_BUILD} == yes ]] && GUI="-wxpython"

	cat <<-EOF > ${MY_PM/.}-grass.desktop
	[Desktop Entry]
	Encoding=UTF-8
	Version=1.0
	Name=Grass ${PV}
	Type=Application
	Comment=GRASS (Geographic Resources Analysis Support System), the original GIS.
	Exec=${TERM} -T Grass -e /usr/bin/${MY_PM/.} ${GUI}
	Path=
	Icon=${PN}-48x48.png
	Categories=Science;Education;
	Terminal=false
	EOF
}
