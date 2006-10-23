# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/grass/grass-6.1.0.ebuild,v 1.1 2006/10/23 16:18:10 nerdboy Exp $

inherit eutils autotools

DESCRIPTION="An open-source GIS with raster and vector functionality"
HOMEPAGE="http://grass.itc.it/"
SRC_URI="http://grass.itc.it/grass61/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
# To-do: get ppc64 gdal deps fixed up

IUSE="ncurses ffmpeg fftw truetype glw gmath jpeg largefile motif mysql nls odbc opengl png postgres proj readline sqlite tcl tk tiff X"

RESTRICT="nostrip"

RDEPEND=">=sys-devel/make-3.80
	>=sys-libs/zlib-1.1.4
	>=sys-devel/flex-2.5.4a
	>=sys-devel/bison-1.35
	>=sys-libs/ncurses-5.3
	>=sys-libs/gdbm-1.8.0
	>=sys-devel/gcc-3.2.2
	sys-apps/man
	>=sci-libs/proj-4.4.7
	sci-libs/gdal
	ffmpeg? ( media-video/ffmpeg )
	fftw? ( =sci-libs/fftw-2* )
	gmath? ( virtual/blas
	    virtual/lapack )
	freetype? ( >=media-libs/freetype-2.0 )
	jpeg? ( media-libs/jpeg )
	motif? ( x11-libs/openmotif )
	mysql? ( dev-db/mysql )
	nls? ( x11-terms/mlterm )
	odbc? ( >=dev-db/unixODBC-2.0.6 )
	opengl? ( ( virtual/opengl )
	    glw? ( media-libs/mesa ) )
	png? ( >=media-libs/libpng-1.2.2 )
	postgres? ( >=dev-db/postgresql-7.3 )
	proj? ( sci-libs/proj )
	readline? ( sys-libs/readline )
	sqlite? ( dev-db/sqlite )
	tcl? >=dev-lang/tcl-8.3
	tk? >=dev-lang/tk-8.3
	tiff? ( >=media-libs/tiff-3.5.7 )
	X? ( || (
	    ( x11-libs/libXmu
	    x11-libs/libXext
	    x11-libs/libXp
	    x11-libs/libX11
	    x11-libs/libXt
	    x11-libs/libSM
	    x11-libs/libICE
	    x11-libs/libXpm
	    x11-libs/libXaw )
	virtual/x11 )
	)"

DEPEND="${RDEPEND}
	X? ( || (
	    ( x11-proto/xproto x11-proto/xextproto )
	        virtual/x11 )
	)"

src_unpack() {
	if use opengl && built_with_use dev-lang/tcl threads; then
		ewarn "GRASS nviz will not work with Tcl compiled with threads!"
		ewarn "Please disable either opengl or tcl threads."
		die "emerge TCL without threads"
	fi
	if use opengl && built_with_use dev-lang/tk threads; then
		ewarn "GRASS nviz will not work with Tk compiled with threads!"
		ewarn "Please disable either opengl or tk threads."
		die "emerge tk without threads"
	fi
	unpack ${A}
	cd ${S}

	epatch rpm/fedora/grass-readline.patch

	eautoconf
}

src_compile() {
	local myconf
	myconf="--prefix=/usr --with-cxx --enable-shared \
		--with-gdal=$(which gdal-config)"

	if use tcl || use tk ; then
		myconf="${myconf} --with-tcltk \
		    --with-tcltk-includes=/usr/include \
		    --with-tcltk-libs=/usr/$(get_libdir)/tcl8.4"
	else
		myconf="${myconf} --without-tcltk"
	fi

	if use ffmpeg; then
		myconf="${myconf} --with-ffmpeg --with-ffmpeg-includes=/usr/include/ffmpeg --with-ffmpeg-libs=/usr/lib"
	else
		myconf="${myconf} --without-ffmpeg"
	fi

	if use freetype; then
		myconf="${myconf} --with-freetype --with-freetype-includes=/usr/include/freetype2"
	fi

	if use mysql; then
		myconf="${myconf} --with-mysql --with-mysql-includes=/usr/include/mysql --with-mysql-libs=/usr/$(get_libdir)/mysql"
	else
		myconf="${myconf} --without-mysql"
	fi

	if use proj; then
		myconf="${myconf} --with-proj --with-proj-includes=/usr/include --with-proj-libs=/usr/lib --with-proj-share=/usr/share/proj"
	else
		myconf="${myconf} --without-proj"
	fi

	if use opengl; then
	    myconf="${myconf} --with-opengl --with-opengl-libs=/usr/$(get_libdir)/opengl/xorg-x11/lib"
	    if use glw; then
		myconf="${myconf} --with-glw"
	    fi
	fi

	if use sqlite; then
		myconf="${myconf} --with-sqlite --with-sqlite-includes=/usr/include
		--with-sqlite-libs=/usr/lib"
	else
		myconf="${myconf} --without-sqlite"
	fi

	export LD_LIBRARY_PATH="/${WORKDIR}/image/usr/${P}/$(get_libdir):${LD_LIBRARY_PATH}"
	econf ${myconf} \
		`use_enable amd64 64bit` \
		`use_with curses` \
		`use_with fftw` \
		`use_with gmath blas` \
		`use_with gmath lapack` \
		`use_with jpeg` \
		`use_enable largefile` \
		`use_with motif` \
		`use_with nls` \
		`use_with odbc` \
		`use_with png` \
		`use_with postgres` \
		`use_with readline` \
		`use_with tiff` \
		`use_with tcl tcltk` \
		`use_with tk tcltk` \
		`use_with X x` || die "Error: configure failed!"
	# patch missing math functions
	sed -i 's:EXTRA_LIBS=:EXTRA_LIBS=-lm :g' ${S}/lib/gmath/Makefile
	sed -i 's:EXTRA_LIBS = :EXTRA_LIBS = -lm :g' ${S}/lib/gis/Makefile
	emake -j1 || die "Error: emake failed!"
}

src_install() {
	make install UNIX_BIN=${D}usr/bin BINDIR=${D}usr/bin \
		PREFIX=${D}usr INST_DIR=${D}usr/${P} \
		|| die "Error: make install failed!"
	sed -i "s:^GISBASE=.*$:GISBASE=/usr/${P}:" \
		${D}usr/bin/grass61

	einfo "Adding env.d entry for Grass6"
	newenvd ${FILESDIR}/99grass-6.1.0 99grass
}
