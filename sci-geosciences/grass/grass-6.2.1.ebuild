# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/grass/grass-6.2.1.ebuild,v 1.10 2008/05/04 01:14:07 nerdboy Exp $

inherit eutils autotools

DESCRIPTION="An open-source GIS with raster and vector functionality, as well as 3D vizualization."
HOMEPAGE="http://grass.itc.it/"
SRC_URI="http://grass.itc.it/grass62/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
# To-do: get ppc64 gdal deps fixed up

IUSE="ffmpeg fftw glw gmath jpeg largefile motif mysql nls odbc opengl png
postgres python readline sqlite tcl tk tiff truetype X"

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
	ffmpeg? ( <=media-video/ffmpeg-0.4.9_p20070616 )
	fftw? ( sci-libs/fftw )
	gmath? ( virtual/blas
	    virtual/lapack )
	jpeg? ( media-libs/jpeg )
	motif? ( x11-libs/openmotif )
	mysql? ( dev-db/mysql )
	odbc? ( >=dev-db/unixODBC-2.0.6 )
	opengl? ( ( virtual/opengl )
	    glw? ( media-libs/mesa ) )
	png? ( >=media-libs/libpng-1.2.2 )
	postgres? ( >=dev-db/postgresql-7.3 )
	python? ( dev-lang/python )
	readline? ( sys-libs/readline )
	sqlite? ( dev-db/sqlite )
	tcl? ( >=dev-lang/tcl-8.4 )
	tk? ( >=dev-lang/tk-8.4 )
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
	)"

DEPEND="${RDEPEND}
	X? (
		x11-proto/xproto
		x11-proto/xextproto
	)"

src_unpack() {
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
		ewarn "OpenGL support also requires Tcl and Tk support."
		die "Set opengl, tcl, and tk useflags."
	fi

	if use glw && ! built_with_use media-libs/mesa motif; then
		ewarn "GRASS OpenGL support needs mesa with motif headers."
		ewarn "Please rebuild mesa with motif support."
		die "Re-emerge mesa with motif."
	fi

	if use opengl && ! use {tcl,tk}; then
		ewarn "GRASS OpenGL support needs both Tcl and Tk."
		die "Please set tcl and tk useflags."
	fi

	if use tcl && ! use tk; then
		ewarn "You set USE='tcl -tk'. GRASS needs both tcl and tk."
		die "Set tk useflag."
	fi

	if use tk && ! use tcl; then
		ewarn "You set USE='-tcl tk'. GRASS needs both tcl and tk."
		die "Set tcl useflag."
	fi

	if use tcl && built_with_use dev-lang/tcl threads; then
		ewarn "GRASS nviz will not work with Tcl compiled with threads!"
		ewarn "Please disable either opengl or tcl threads."
		die "Emerge TCL without threads."
	fi
	if use tk && built_with_use dev-lang/tk threads; then
		ewarn "GRASS nviz will not work with Tk compiled with threads!"
		ewarn "Please disable either opengl or tk threads."
		die "Emerge tk without threads."
	fi
	unpack ${A}
	cd "${S}"
	use ffmpeg && epatch "${FILESDIR}"/${P}-ffmpeg-fix.patch
	epatch rpm/fedora/grass-readline.patch
	elibtoolize
}

src_compile() {
	local myconf
	myconf="--prefix=/usr --with-cxx --enable-shared \
		--with-gdal=$(type -P gdal-config) --with-curses --with-proj \
		--with-proj-includes=/usr/include --with-proj-libs=/usr/lib \
		--with-proj-share=/usr/share/proj"

	if use tcl || use tk; then
		myconf="${myconf} --with-tcltk \
		    --with-tcltk-includes=/usr/include \
		    --with-tcltk-libs=/usr/$(get_libdir)/tcl8.4 --with-x"
	else
		myconf="${myconf} --without-tcltk --without-x"
	fi

	if use opengl; then
	    epatch "${FILESDIR}"/${P}-html-nviz-fix.patch
	    myconf="${myconf} --with-opengl --with-opengl-libs=/usr/$(get_libdir)/opengl/xorg-x11/lib"
	    if use glw; then
		myconf="${myconf} --with-glw"
	    fi
	else
	    epatch "${FILESDIR}"/${P}-html-nonviz.patch
	    myconf="${myconf} --without-opengl --without-glw"
	fi

	if use ffmpeg; then
		myconf="${myconf} --with-ffmpeg --with-ffmpeg-includes=/usr/include/ffmpeg --with-ffmpeg-libs=/usr/lib"
	else
		myconf="${myconf} --without-ffmpeg"
	fi

	if use truetype; then
		myconf="${myconf} --with-freetype --with-freetype-includes=/usr/include/freetype2"
	fi

	if use mysql; then
		myconf="${myconf} --with-mysql --with-mysql-includes=/usr/include/mysql --with-mysql-libs=/usr/$(get_libdir)/mysql"
	else
		myconf="${myconf} --without-mysql"
	fi

	if use sqlite; then
		myconf="${myconf} --with-sqlite --with-sqlite-includes=/usr/include
		--with-sqlite-libs=/usr/lib"
	else
		myconf="${myconf} --without-sqlite"
	fi

	export LD_LIBRARY_PATH="/${WORKDIR}/image/usr/${P}/$(get_libdir):${LD_LIBRARY_PATH}"
	econf ${myconf} --with-libs=/usr/$(get_libdir) \
		$(use_enable amd64 64bit) \
		$(use_with fftw) \
		$(use_with jpeg) \
		$(use_enable largefile) \
		$(use_with motif) \
		$(use_with nls) \
		$(use_with odbc) \
		$(use_with png) \
		$(use_with postgres) \
		$(use_with python) \
		$(use_with readline) \
		$(use_with tiff) \
		$(use_with tcl tcltk) || die "configure failed!"
	# patch missing math functions
	sed -i 's:EXTRA_LIBS=:EXTRA_LIBS=-lm :g' "${S}"/lib/gmath/Makefile
	sed -i 's:EXTRA_LIBS = :EXTRA_LIBS = -lm :g' "${S}"/lib/gis/Makefile

	emake -j1 || die "emake failed!"
}

src_install() {
	make install UNIX_BIN="${D}"usr/bin BINDIR="${D}"usr/bin \
		PREFIX="${D}"usr INST_DIR="${D}"usr/grass62 \
		|| die "make install failed!"

	sed -i -e "s:^GISBASE=.*$:GISBASE=/usr/grass62:" \
		"${D}"usr/bin/grass62 || die "sed failed!"

	# Grass Extension Manager conflicts with ruby gems
	mv "${D}"usr/bin/gem "${D}"usr/grass62/bin/

	einfo "Adding env.d entry for Grass6"
	newenvd "${FILESDIR}"/99grass-6.2 99grass-6
}
