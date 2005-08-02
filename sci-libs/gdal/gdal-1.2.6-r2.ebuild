# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/gdal/gdal-1.2.6-r2.ebuild,v 1.2 2005/08/02 23:51:30 herbs Exp $

inherit eutils libtool gnuconfig distutils multilib

IUSE="jpeg png geos gif grass jasper netcdf hdf python postgres mysql odbc sqlite ogdi fits debug"

DESCRIPTION="GDAL is a translator library for raster geospatial data formats"
HOMEPAGE="http://www.remotesensing.org/gdal/index.html"
SRC_URI="http://dl.maptools.org/dl/gdal/${P}.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
# need to get these arches updated on several libs first
#KEYWORDS="~alpha ~hppa ~ppc64"

DEPEND=">=sys-libs/zlib-1.1.4
	>=media-libs/tiff-3.7.0
	sci-libs/libgeotiff
	jpeg? ( media-libs/jpeg )
	gif? ( media-libs/giflib )
	png? ( media-libs/libpng )
	python? ( dev-lang/python )
	fits? ( sci-libs/cfitsio )
	ogdi? ( sci-libs/ogdi )
	|| (
		postgres? ( dev-db/postgresql )
		mysql? ( dev-db/mysql )
	)
	|| (
		netcdf? ( sci-libs/netcdf )
		hdf? ( sci-libs/hdf )
	)
	jasper? ( media-libs/jasper )
	odbc?   ( dev-db/unixODBC )
	geos?   ( sci-libs/geos )
	grass? ( ~sci-geosciences/grass-6.0.0 )
	sqlite? ( dev-db/sqlite )"

src_unpack() {
	unpack ${A}
	cd ${S}
	elibtoolize --patch-only
	gnuconfig_update
	if useq netcdf && useq hdf; then
		einfo	"Checking is HDF4 compiled with szip..."
		if built_with_use hdf szip ; then
			einfo	"Found HDF4 compiled with szip. Nice."
		else
			ewarn 	"HDF4 must be compiled with szip USE flag!"
			einfo 	"Emerge HDF with szip USE flag and then emerge GDAL."
			die 	"HDF4 not merged with szip use flag"
		fi
	fi
}

src_compile() {
	distutils_python_version
	# This package uses old borked automake/autoconf and libtool, so
	# it doesn't work without ${D} (or with econf and einstall).
	pkg_conf="--datadir=${D}usr/share/gdal --includedir=${D}usr/include/gdal \
		--libdir=${D}usr/$(get_libdir) --enable-shared --with-gnu-ld --with-pic"

	use_conf="$(use_with jpeg) $(use_with png) $(use_with mysql) \
		$(use_with postgres pg) $(use_with fits cfitsio) \
		$(use_with netcdf) $(use_with hdf hdf4) $(use_with geos) \
		$(use_with sqlite) $(use_with jasper) $(use_with odbc)"

	# It can't find this
	if useq ogdi ; then
		use_conf="--with-ogdi=/usr/$(get_libdir) ${use_conf}"
	fi

	if useq gif ; then
		use_conf="--with-gif=internal ${use_conf}"
	else
		use_conf="--with-gif=no ${use_conf}"
	fi

	if useq debug ; then
	        export CFG=debug
	fi

	#enable newer Grass support only
	if useq grass ; then
		use_conf="--with-grass=/usr/grass60 ${use_conf}"
		use_conf="--with-libgrass=no ${use_conf}"
	fi

	if useq python ; then
		use_conf="--with-pymoddir=${D}usr/lib/python${PYVER}/site-packages \
			${use_conf}"
	else
		use_conf="--with-python=no ${use_conf}"
	fi

	myconf="${pkg_conf} ${use_conf}"

	./configure --prefix=${D}usr --exec-prefix=${D}usr \
	    --with-pymoddir=${D}usr/lib/python${PYVER}/site-packages \
	    ${myconf}

	# Patch libtool here since it's not created until after configure runs
	sed -i -e "s:hardcode_into_libs=yes:hardcode_into_libs=no:g" libtool
	echo '#undef GDAL_PREFIX' >> port/cpl_config.h
	echo '#define GDAL_PREFIX "/usr"' >> port/cpl_config.h
	emake || die "emake failed"
}

src_install() {
	# einstall causes sandbox violations on /usr/lib/libgdal.so
	#einstall || die "einstall failed"
	make DESTDIR=${D} install
	dosed "s:${D}usr:/usr:g" /usr/bin/gdal-config
	dodoc Doxyfile.man Doxyfile HOWTO-RELEASE NEWS
}

pkg_postinst() {
	einfo "GDAL is most useful with full graphics support enabled via"
	einfo "USE flags: png, jpeg, and gif. Optional python, fits, ogdi,"
	einfo "and support for either netcdf or HDF4 is available, as well"
	einfo "as either mysql or postgres."
	ewarn
	einfo "Note: tiff and geotiff are now hard depends, so no USE flags."
	einfo "Also, this package will check for netcdf before hdf, so if you"
	einfo "prefer hdf, please emerge hdf with USE=szip prior to emerging"
	einfo "gdal."
}
