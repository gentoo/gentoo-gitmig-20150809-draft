# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/grass/grass-6.0.1.ebuild,v 1.17 2008/05/21 19:01:32 dev-zero Exp $

inherit eutils

DESCRIPTION="An open-source GIS with raster and vector functionality"
HOMEPAGE="http://grass.itc.it/"
SRC_URI="http://grass.itc.it/grass60/source/${P}.tar.gz
	http://grass.meteo.uni.wroc.pl/grass60/source/${P}.tar.gz
	http://grass.ibiblio.org/grass60/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="6"
KEYWORDS="amd64 ppc sparc x86"
# To-do: get ppc64 gdal deps fixed up

# add gdal back to use flags once grass is fixed
IUSE="fftw jpeg motif mysql nls odbc opengl png postgres readline tk tiff truetype"

RESTRICT="strip"

RDEPEND=">=sys-devel/make-3.80
	>=sys-libs/zlib-1.1.4
	>=sys-devel/flex-2.5.4a
	>=sys-devel/bison-1.35
	>=sys-libs/ncurses-5.3
	>=sys-libs/gdbm-1.8.0
	>=sys-devel/gcc-3.2.2
	virtual/man
	>=sci-libs/proj-4.4.7
	sci-libs/gdal
	fftw? ( =sci-libs/fftw-2* )
	jpeg? ( media-libs/jpeg )
	postgres? ( >=virtual/postgresql-server-7.3 )
	mysql? ( virtual/mysql )
	odbc? ( >=dev-db/unixODBC-2.0.6 )
	png? ( >=media-libs/libpng-1.2.2 )
	readline? ( sys-libs/readline )
	tiff? ( >=media-libs/tiff-3.5.7 )
	truetype? ( >=media-libs/freetype-2.0 )
	nls? ( x11-terms/mlterm )
	opengl? ( virtual/opengl )
	tk? ( >=dev-lang/tk-8.3.4 )
	motif? ( x11-libs/openmotif )
	x11-libs/libXmu
	x11-libs/libXext
	x11-libs/libXp
	x11-libs/libX11
	x11-libs/libXt
	x11-libs/libSM
	x11-libs/libICE
	x11-libs/libXpm
	x11-libs/libXaw"

DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xextproto"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch rpm/fedora/grass-readline.patch
	sed -i -e "s/relid'/relid/" "${S}"/configure || die "sed blew chunks"
}

src_compile() {

	MYCONF=" --with-cxx --enable-shared --with-gdal=/usr/bin/gdal-config"

	if use truetype; then
		MYCONF="${MYCONF} --with-freetype-includes=/usr/include/freetype2/"
	fi

	use mysql && MYCONF="${MYCONF} --with-mysql \
		--with-mysql-includes=/usr/include/mysql \
		--with-mysql-libs=/usr/$(get_libdir)/mysql" \
		|| MYCONF="${MYCONF} --without-mysql"

	if use opengl; then
		MYCONF="${MYCONF} --with-opengl-libs=/usr/$(get_libdir)/opengl/xorg-x11/lib/"
	fi

	# apparently gdal isn't optional with this version

	export LD_LIBRARY_PATH="/${WORKDIR}/image/usr/grass60/$(get_libdir):${LD_LIBRARY_PATH}"
	./configure \
		`use_with postgres` \
		`use_with motif` \
		`use_with fftw` \
		`use_with truetype freetype` \
		`use_with jpeg` \
		`use_with png` \
		`use_with tiff` \
		`use_with odbc` \
		`use_enable amd64 64bit` \
		`use_with opengl` \
		`use_with readline` \
		$(use_with tk tcltk) \
		${MYCONF} || die "Error: configure failed!"
	emake -j1 || die "Error: emake failed!"
}

src_install() {
	make install \
		prefix="${D}"/usr UNIX_BIN="${D}"/usr/bin BINDIR="${D}"/usr/bin PREFIX=${D}/usr \
			|| die "Error: make install failed!"
	sed -i "s:^GISBASE=.*$:GISBASE=/usr/grass60:" \
		"${D}"/usr/bin/grass60

	# This is required for GRASS dependent ebuilds (ie. QGIS)
	mv "${D}"/usr/${P} "${D}"/usr/grass60

	einfo "Adding env.d entry for Grass6"
	newenvd "${FILESDIR}"/99grass-6 99grass
}
