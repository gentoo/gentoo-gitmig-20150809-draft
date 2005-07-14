# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/grass/grass-6.0.0.ebuild,v 1.2 2005/07/14 20:55:00 agriffis Exp $

inherit eutils

DESCRIPTION="An open-source GIS with raster and vector functionality"
HOMEPAGE="http://grass.itc.it/"
SRC_URI="http://grass.itc.it/grass60/source/${P}.tar.gz
	http://grass.meteo.uni.wroc.pl/grass60/source/${P}.tar.gz
	http://grass.ibiblio.org/grass60/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="6"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE="X blas fftw gd gdal jpeg lapack motif mysql nls odbc opengl png postgres readline tcltk tiff truetype"
RESTRICT="nostrip"

DEPEND=">=sys-devel/make-3.80
	>=sys-libs/zlib-1.1.4
	>=sys-devel/flex-2.5.4a
	>=sys-devel/bison-1.35
	>=sys-libs/ncurses-5.3
	>=sys-libs/gdbm-1.8.0
	>=sys-devel/gcc-3.2.2
	sys-apps/man
	>=sci-libs/proj-4.4.7
	blas? ( virtual/blas )
	fftw? ( =sci-libs/fftw-2* )
	sci-libs/gdal
	gd? ( >=media-libs/gd-1.8.3 )
	jpeg? ( media-libs/jpeg )
	lapack? ( virtual/lapack )
	motif? ( x11-libs/openmotif )
	|| (
	    postgres? ( >=dev-db/postgresql-7.3 )
	    mysql? ( dev-db/mysql )
	)
	odbc? ( >=dev-db/unixODBC-2.0.6 )
	png? ( >=media-libs/libpng-1.2.2 )
	readline? ( sys-libs/readline )
	tcltk? ( >=dev-lang/tcl-8.3.4
		>=dev-lang/tk-8.3.4 )
	tiff? ( >=media-libs/tiff-3.5.7 )
	truetype? ( >=media-libs/freetype-2.0 )
	X? ( virtual/x11 )
	nls? ( x11-terms/mlterm )"
	# Mesa 3.5 is currenlty borked on x86
	#nviz? ( >=media-libs/mesa-3.5 )"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch rpm/fedora/grass-readline.patch
}

src_compile() {

	MYCONF=" --with-cxx --enable-shared"

	if use truetype; then
		MYCONF="${MYCONF} --with-freetype-includes=/usr/include/freetype2/ "
	fi

	use mysql && MYCONF="${MYCONF} --with-mysql \
		--with-mysql-includes=/usr/include/mysql \
		--with-mysql-libs=/usr/lib/mysql" \
		|| MYCONF="${MYCONF} --without-mysql"

	if use opengl; then
	    MYCONF="${MYCONF} --with-opengl-libs=/usr/lib/opengl/xorg-x11/lib/"
	fi

	export LD_LIBRARY_PATH="/${WORKDIR}/image/usr/grass60/lib:${LD_LIBRARY_PATH}"
	./configure \
		`use_with tcltk` \
		`use_with postgres` \
		`use_with motif` \
		`use_with blas` \
		`use_with lapack` \
		`use_with fftw` \
		`use_with truetype freetype` \
		`use_with jpeg` \
		`use_with png` \
		`use_with tiff` \
		`use_with odbc` \
		`use_enable amd64 64bit` \
		`use_with opengl opengl` \
		`use_with gd` \
		`use_with gdal` \
		`use_with readline` \
		`use_with X` \
		${MYCONF} || die "Error: configure failed!"
	emake -j1 || die "Error: emake failed!"
}

src_install() {
	make install \
		prefix=${D}/usr UNIX_BIN=${D}/usr/bin BINDIR=${D}/usr/bin PREFIX=${D}/usr \
		    || die "Error: make install failed!"
	sed -i "s:^GISBASE=.*$:GISBASE=/usr/grass60:" \
		${D}/usr/bin/grass60

	# This is required for GRASS dependent ebuilds (ie. QGIS)
	mv ${D}/usr/${P} ${D}/usr/grass60

	einfo "Adding env.d entry for Grass6"
	insinto /etc/env.d
	newins ${FILESDIR}/99grass-6 99grass
}
