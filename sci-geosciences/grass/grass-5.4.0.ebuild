# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/grass/grass-5.4.0.ebuild,v 1.14 2008/05/21 19:01:32 dev-zero Exp $

inherit eutils toolchain-funcs

DESCRIPTION="An open-source GIS with raster and vector functionality"
HOMEPAGE="http://grass.itc.it/"
SRC_URI="http://grass.itc.it/grass54/source/${P}.tar.gz
	http://grass.meteo.uni.wroc.pl/grass54/source/${P}.tar.gz
	http://grass.ibiblio.org/grass54/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 sparc x86"
IUSE="tk png jpeg tiff postgres odbc motif gdal mysql blas lapack X fftw truetype nls opengl"

RDEPEND=">=sys-devel/make-3.80
	>=sys-libs/zlib-1.1.4
	>=sys-devel/flex-2.5.4a
	>=sys-devel/bison-1.35
	>=sys-libs/ncurses-5.3
	>=sys-libs/gdbm-1.8.0
	>=sys-devel/gcc-3.2.2
	virtual/man
	>=sci-libs/proj-4.4.7
	blas? ( virtual/blas )
	lapack? ( virtual/lapack )
	fftw? ( =sci-libs/fftw-2* )
	gdal? ( >=sci-libs/gdal-1.2.6 )
	jpeg? ( media-libs/jpeg )
	tiff? ( media-libs/tiff )
	png? ( >=media-libs/libpng-1.2.2 )
	mysql? ( virtual/mysql )
	odbc? ( >=dev-db/unixODBC-2.0.6 )
	postgres? ( >=virtual/postgresql-server-7.3 )
	nls? ( x11-terms/mlterm )
	tk? ( >=dev-lang/tk-8.3.4 )
	truetype? ( >=media-libs/freetype-2.0.0 )
	motif? ( x11-libs/openmotif )
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
	unpack ${A}

	cd "${S}"
	einfo "Patching configure..."
	sed -i -e "s:relid':relid:g" configure || die "sed blew chunks"
}

src_compile() {
	MYCONF="--prefix=${D}usr --host=${CHOST} --infodir=${D}usr/share/info \
		--libdir=${D}usr/$(get_libdir) --mandir=${D}usr/share/man \
		--enable-shared --with-cxx"

	use truetype \
		&& MYCONF="${MYCONF} --with-freetype \
		--with-freetype-includes=/usr/include/freetype2 \
		--with-freetype-libs=/usr/lib" \
		|| MYCONF="${MYCONF} --without-freetype"

	use gdal \
		&& MYCONF="${MYCONF} --with-gdal=/usr/bin/gdal-config" \
		|| MYCONF="${MYCONF} --without-gdal"

	use mysql \
		&& MYCONF="${MYCONF} --with-mysql --with-mysql-includes=/usr/include/mysql \
		 --with-mysql-libs=/usr/lib/mysql" \
		|| MYCONF="${MYCONF} --without-mysql"

	mkdir ./grass-build
	cd ./grass-build

	../configure ${MYCONF} \
		`use_with X` \
		`use_with readline` \
		`use_with tk tcltk` \
		`use_with postgres` \
		`use_with motif` \
		`use_with blas` \
		`use_with lapack` \
		`use_with fftw` \
		`use_with jpeg` \
		`use_with png` \
		`use_with tiff` \
		`use_with odbc` \
		`use_with nls` \
		`use_enable amd64 64bit` \
		`use_with opengl` || die "Error: configure failed!"
	emake -j1 || die "Error: emake failed!"
}

src_install() {
	cd "${WORKDIR}"/${P}/grass-build
	make DESTDIR="${D}" install \
		|| die "Error: make install failed!"
	sed -i "s:^GISBASE=.*$:GISBASE=/usr/grass54:" \
		"${D}"usr/bin/grass54
	# Install grass always in one directory
	mv "${D}"usr/${P} "${D}"usr/grass54
}
