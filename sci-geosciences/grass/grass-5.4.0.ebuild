# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/grass/grass-5.4.0.ebuild,v 1.1 2005/08/08 06:38:25 nerdboy Exp $

inherit eutils toolchain-funcs

DESCRIPTION="An open-source GIS with raster and vector functionality"
HOMEPAGE="http://grass.itc.it/"
SRC_URI="http://grass.itc.it/grass54/source/${P}.tar.gz
	http://grass.meteo.uni.wroc.pl/grass54/source/${P}.tar.gz
	http://grass.ibiblio.org/grass54/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc"
IUSE="tcltk png jpeg tiff postgres odbc motif gdal mysql blas lapack X fftw truetype nls opengl"

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
	lapack? ( virtual/lapack )
	fftw? ( =sci-libs/fftw-2* )
	gdal? ( >=sci-libs/gdal-1.2.6 )
	jpeg? ( media-libs/jpeg )
	tiff? ( media-libs/tiff )
	png? ( >=media-libs/libpng-1.2.2 )
	mysql? ( dev-db/mysql )
	odbc? ( >=dev-db/unixODBC-2.0.6 )
	postgres? ( >=dev-db/postgresql-7.3 )
	tcltk? ( >=dev-lang/tcl-8.3.4
		>=dev-lang/tk-8.3.4 )
	truetype? ( >=media-libs/freetype-2.0.0 )
	motif? ( x11-libs/openmotif )
	X? ( virtual/x11 )
	nls? ( x11-terms/mlterm )"

src_compile() {
	MYCONF="--prefix=${D}usr --host=${CHOST} --infodir=${D}usr/share/info \
		--libdir=${D}usr/$(get_libdir) --mandir=${D}usr/share/man \
		--enable-shared --with-cxx "

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
		`use_with tcltk` \
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
	cd ${WORKDIR}/${P}/grass-build
	make DESTDIR=${D} install \
		|| die "Error: make install failed!"
	sed -i "s:^GISBASE=.*$:GISBASE=/usr/grass54:" \
		${D}usr/bin/grass54
	# Install grass always in one directory
	mv ${D}usr/${P} ${D}usr/grass54
}
