# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/grass/grass-6.2.3.ebuild,v 1.2 2008/05/01 16:37:40 mr_bones_ Exp $

inherit eutils autotools fdo-mime versionator

MY_PV=$(get_version_component_range 1-2 ${PV})
MY_PVM=$(delete_all_version_separators ${MY_PV})
MY_PM=${PN}${MY_PVM}

DESCRIPTION="An open-source GIS with raster and vector functionality, as well as 3D vizualization."
HOMEPAGE="http://grass.itc.it/"
SRC_URI="http://grass.itc.it/${MY_PM}/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

IUSE="ffmpeg fftw glw gmath jpeg largefile mysql nls odbc opengl png \
postgres python readline sqlite tiff truetype X"

RESTRICT="strip"

RDEPEND=">=sys-devel/make-3.80
	>=sys-libs/zlib-1.1.4
	>=sys-devel/flex-2.5.4a
	>=sys-devel/bison-1.35
	>=sys-libs/ncurses-5.3
	>=sys-libs/gdbm-1.8.0
	>=sys-devel/gcc-3.2.2
	|| (
	    sys-apps/man
	    sys-apps/man-db )
	sci-libs/gdal
	>=sci-libs/proj-4.4.7
	ffmpeg? ( media-video/ffmpeg )
	fftw? ( sci-libs/fftw )
	gmath? ( virtual/blas
	    virtual/lapack )
	jpeg? ( media-libs/jpeg )
	mysql? ( dev-db/mysql )
	odbc? ( >=dev-db/unixODBC-2.0.6 )
	opengl? ( ( virtual/opengl )
	    ( x11-libs/openmotif )
	    glw? ( media-libs/mesa ) )
	png? ( >=media-libs/libpng-1.2.2 )
	postgres? ( >=dev-db/postgresql-7.3 )
	python? ( dev-lang/python )
	readline? ( sys-libs/readline )
	sqlite? ( dev-db/sqlite )
	tiff? ( >=media-libs/tiff-3.5.7 )
	truetype? ( >=media-libs/freetype-2.0 )
	X? (
		x11-libs/libXmu
		x11-libs/libXext
		x11-libs/libXp
		x11-libs/libX11
		x11-libs/libXt
		x11-libs/libSM
		x11-libs/libICE
		x11-libs/libXpm
		x11-libs/libXaw
		>=dev-lang/tcl-8.4
		>=dev-lang/tk-8.4
	)"

DEPEND="${RDEPEND}
	X? (
		x11-proto/xproto
		x11-proto/xextproto
	)"

pkg_setup() {
	local myblas
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

	if use glw && ! use opengl; then
		ewarn "You set USE='glw -opengl'. GLw support needs OpenGL."
		ewarn "OpenGL support also requires X."
		die "Set opengl and X useflags."
	fi

	if use glw && ! built_with_use media-libs/mesa motif; then
		ewarn "GRASS GLw/OpenGL support needs mesa with motif headers."
		ewarn "Please rebuild mesa with motif support."
		die "Re-emerge mesa with motif."
	fi

	if use opengl && ! use X; then
		ewarn "GRASS OpenGL support needs X (will also pull in Tcl/Tk)."
		die "Please set the X useflag."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch rpm/fedora/grass-readline.patch

	if use opengl; then
	    epatch "${FILESDIR}"/${P}-html-nviz-fix.patch
	else
	    epatch "${FILESDIR}"/${P}-html-nonviz.patch
	fi

	# patch missing math functions (yes, this is still needed)
	sed -i -e "s:\$(EXTRA_LIBS):\$(EXTRA_LIBS) \$(MATHLIB):g" include/Make/Shlib.make
	echo "MATHLIB=-lm" >> include/Make/Rules.make
}

src_compile() {
	local myconf
	myconf="--prefix=/usr --with-cxx --enable-shared \
		--with-gdal=$(type -P gdal-config) --with-curses --with-proj \
		--with-includes=/usr/include --with-libs=/usr/$(get_libdir) \
		--with-proj-includes=/usr/include \
		--with-proj-libs=/usr/$(get_libdir) \
		--with-proj-share=/usr/share/proj"

	if use X; then
		myconf="${myconf} --with-tcltk --with-x \
		    --with-tcltk-includes=/usr/include \
		    --with-tcltk-libs=/usr/$(get_libdir)/tcl8.4"
	else
		myconf="${myconf} --without-tcltk --without-x"
	fi

	if use opengl; then
	    myconf="${myconf} --with-opengl --with-opengl-libs=/usr/$(get_libdir)/opengl/xorg-x11/lib"
	    if use glw; then
		myconf="${myconf} --with-glw"
	    fi
	else
	    myconf="${myconf} --without-opengl --without-glw"
	fi

	if use ffmpeg; then
		myconf="${myconf} --with-ffmpeg --with-ffmpeg-includes=/usr/include/ffmpeg \
		    --with-ffmpeg-libs=/usr/$(get_libdir)"
	else
		myconf="${myconf} --without-ffmpeg"
	fi

	if use truetype; then
		myconf="${myconf} --with-freetype \
		    --with-freetype-includes=/usr/include/freetype2"
	fi

	if use mysql; then
		myconf="${myconf} --with-mysql --with-mysql-includes=/usr/include/mysql \
		    --with-mysql-libs=/usr/$(get_libdir)/mysql"
	else
		myconf="${myconf} --without-mysql"
	fi

	if use sqlite; then
		myconf="${myconf} --with-sqlite --with-sqlite-includes=/usr/include
		--with-sqlite-libs=/usr/$(get_libdir)"
	else
		myconf="${myconf} --without-sqlite"
	fi

	econf ${myconf} --with-libs=/usr/$(get_libdir) \
		$(use_enable amd64 64bit) \
		$(use_with fftw) \
		$(use_with gmath blas) \
		$(use_with gmath lapack) \
		$(use_with jpeg) \
		$(use_enable largefile) \
		$(use_with opengl motif) \
		$(use_with nls) \
		$(use_with odbc) \
		$(use_with png) \
		$(use_with postgres) \
		$(use_with python) \
		$(use_with readline) \
		$(use_with tiff) || die "configure failed!"

	emake -j1 || die "emake failed!"
}

src_install() {
	elog "Grass Home is ${MY_PM}"
	make install UNIX_BIN="${D}"usr/bin BINDIR="${D}"usr/bin \
		PREFIX="${D}"usr INST_DIR="${D}"usr/${MY_PM} \
		|| die "make install failed!"

	#
	sed -i -e "s@${D}@/@" "${D}"usr/bin/${MY_PM}

	# Grass Extension Manager conflicts with ruby gems
	mv "${D}"usr/bin/gem "${D}"usr/${MY_PM}/bin/

	ebegin "Adding env.d and desktop entry for Grass6..."
	    generate_files
	    doenvd 99grass-6
	    if use X; then
		doicon "${FILESDIR}"/grass_icon.png
		domenu ${MY_PM}-grass.desktop
	    fi
	eend ${?}
}

pkg_postinst() {
	use X && fdo-mime_desktop_database_update

	elog "Note this version re-enables support for threads in Tcl and Tk."
	elog "Enable the threads USE flag and rebuild to try it."
}

pkg_postrm() {
	use X && fdo-mime_desktop_database_update
}

generate_files() {
	cat <<-EOF > 99grass-6
	GRASS_LD_LIBRARY_PATH="/usr/${MY_PM}/lib"
	LDPATH="/usr/${MY_PM}/lib"
	MANPATH="/usr/${MY_PM}/man"
	GRASS_HOME="/usr/${MY_PM}"
	EOF

	cat <<-EOF > ${MY_PM}-grass.desktop
	[Desktop Entry]
	Encoding=UTF-8
	Version=1.0
	Name=Grass ${PV}
	Type=Application
	Comment=GRASS Open Source GIS, derived from the original US Army Corps of Engineers project.
	Exec=${TERM} -T Grass -e /usr/bin/${MY_PM} -gui
	Path=
	Icon=grass_icon.png
	Categories=Science;Education;
	Terminal=true
	EOF
}
