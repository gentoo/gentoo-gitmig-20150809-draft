# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/grass/grass-5.0.3.ebuild,v 1.4 2005/01/10 20:28:31 kugelfang Exp $

DESCRIPTION="An open-source GIS with raster and vector functionality"
HOMEPAGE="http://grass.itc.it/
	http://www.grass-japan.org/FOSS4G/GRASS/grass-inten.html"
SRC_URI="!nls? ( http://grass.ibiblio.org/${PN}5/source/${P}_src.tar.gz )
	nls? ( http://www.grass-japan.org/FOSS4G/GRASS/${P/-/}_i18n_src.tar.gz
	tcltk? ( http://www.grass-japan.org/FOSS4G/GRASS/tcltkgrass-i18n.tar.gz ) )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE="tcltk png jpeg tiff postgres odbc gd motif truetype nls"
# Removed cause mesa never goes stable.
# IUSE="${IUSE} nviz"

DEPEND=">=sys-devel/make-3.80
	>=sys-libs/zlib-1.1.4
	>=sys-devel/flex-2.5.4a
	>=sys-devel/bison-1.35
	>=sys-libs/ncurses-5.3
	virtual/x11
	>=sys-libs/gdbm-1.8.0
	>=sys-devel/gcc-3.2.2
	=sci-libs/fftw-2*
	>=sci-libs/lapack-3.0
	>=sci-libs/blas-19980702
	>=media-libs/netpbm-9.12
	>=dev-lang/R-1.6.1
	tcltk? ( >=dev-lang/tcl-8.3.4
		>=dev-lang/tk-8.3.4 )
	png? ( >=media-libs/libpng-1.2.5 )
	jpeg? ( >=media-libs/jpeg-6b )
	tiff? ( >=media-libs/tiff-3.5.7 )
	postgres? ( >=dev-db/postgresql-7.3.2 )
	odbc? ( >=dev-db/unixODBC-2.0.6 )
	gd? ( >=media-libs/gd-1.8.3 )
	motif? ( x11-libs/openmotif )
	truetype? ( >=media-libs/freetype-2.1.3 )
	nls? ( x11-terms/mlterm )"
	#nviz? ( >=media-libs/mesa-3.5 )"

use nls && S="${WORKDIR}/${P}-i18n"

src_compile() {

	local myconf="--with-blas --with-lapack"

	use tcltk \
	&& myconf="${myconf} --with-tcltk" \
	|| myconf="${myconf} --without-tcltk"

	use png \
	&& myconf="${myconf} --with-png" \
	|| myconf="${myconf} --without-png"

	use jpeg \
	&& myconf="${myconf} --with-jpeg" \
	|| myconf="${myconf} --without-jpeg"

	use tiff \
	&& myconf="${myconf} --with-tiff" \
	|| myconf="${myconf} --without-tiff"

	use odbc \
	&& myconf="${myconf} --with-odbc" \
	|| myconf="${myconf} --without-odbc"

	use gd \
	&& myconf="${myconf} --with-gd" \
	|| myconf="${myconf} --without-gd"

	use postgres \
	&& myconf="${myconf} --with-postgres --with-postgres-includes=/usr/include/postgresql/server" \
	|| myconf="${myconf} --without-postgres"

	use motif \
	&& myconf="${myconf} --with-motif --with-motif-includes=/usr/X11R6/include" \
	|| myconf="${myconf} --without-motif"

	use truetype \
	&& myconf="${myconf} --with-freetype --with-freetype-includes=/usr/include/freetype2" \
	|| myconf="${myconf} --without-freetype"

	#use nviz \
	#&& myconf="${myconf} --with-glw" \
	#|| myconf="${myconf} --without-glw"

	use nls \
	&& myconf="${myconf} --with-nls --with-freetype"

	./configure \
		--host=${CHOST} \
		--prefix=${D}/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myconf} || die "./configure failed"
	emake -j1 || die "emake failed"

	# clean ccache directories left in ${S}
	find . -type d -name ".ccache" | xargs rm -rf
}

src_install() {
	make install || die
	dosed "s:^GISBASE=.*$:GISBASE=/usr/grass5:" \
	  /usr/bin/grass5

	if use nls && use tcltk ; then
		pushd ${D}/usr/grass5
		unpack tcltkgrass-i18n.tar.gz
		dodoc AUTHORS BUGS NEWS.html README TODO.txt
		dohtml REQUIREMENTS.html
		rm [A-Z]*
		popd
	fi
}
