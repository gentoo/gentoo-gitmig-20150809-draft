# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/gdal/gdal-1.2.6-r3.ebuild,v 1.2 2005/08/22 16:32:27 swegener Exp $

inherit eutils libtool gnuconfig distutils

IUSE="jpeg png geos gif grass jasper netcdf hdf python postgres mysql odbc sqlite ogdi fits doc debug"

DESCRIPTION="GDAL is a translator library for raster geospatial data formats (includes OGR support)"
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
	sqlite? ( dev-db/sqlite )
	doc? ( app-doc/doxygen )"

src_unpack() {
	unpack ${A}
	cd ${S}
	elibtoolize --patch-only
	gnuconfig_update
	if useq netcdf && useq hdf; then
		einfo	"Checking is HDF4 compiled with szip..."
		if built_with_use sci-libs/hdf szip ; then
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

	pkg_conf="--prefix=${D}usr --exec-prefix=${D}usr --bindir=${D}usr/bin \
		--datadir=${D}usr/share/gdal --includedir=${D}usr/include/gdal \
		--libdir=${D}usr/$(get_libdir) --mandir=${D}usr/share/man
		--with-pymoddir=${D}usr/lib/python${PYVER}/site-packages \
		--enable-static=no --enable-shared=yes --with-gnu-ld"

	# the above should make libtool behave for the most part

	use_conf="$(use_with jpeg) $(use_with png) $(use_with mysql) \
		$(use_with postgres pg) $(use_with fits cfitsio) \
		$(use_with netcdf) $(use_with hdf hdf4) $(use_with geos) \
		$(use_with sqlite) $(use_with jasper) $(use_with odbc)"

	# It can't find this
	if useq ogdi ; then
		use_conf="--with-ogdi=/usr/lib ${use_conf}"
	fi

	if useq gif ; then
		use_conf="--with-gif=internal ${use_conf}"
	else
		use_conf="--with-gif=no ${use_conf}"
	fi

	if useq debug ; then
	        export CFG=debug
	fi

	# Enable newer Grass support only
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

	# Fix doc path just in case
	sed -i -e "s:@exec_prefix@/doc:${D}usr/share/doc/${PF}/html:g" GDALmake.opt.in

	./configure --with-pymoddir=${D}usr/lib/python${PYVER}/site-packages \
	    ${pkg_conf} ${use_conf}

	# Patch libtool here since it's not created until after configure runs
	sed -i -e "s:hardcode_into_libs=yes:hardcode_into_libs=no:g" libtool
	echo '#undef GDAL_PREFIX' >> port/cpl_config.h
	echo '#define GDAL_PREFIX "/usr"' >> port/cpl_config.h
	emake  || die "emake failed"
	if useq doc ; then
	    emake docs || die "emake docs failed"
	fi
}

src_install() {
	# einstall causes sandbox violations on /usr/lib/libgdal.so
	make DESTDIR=${D} install || die "make install failed"
	dosed "s:${D}usr:/usr:g" /usr/bin/gdal-config
	dosed "s:/usr/local/bin/perl:/usr/bin/perl:g" ${S}/Doxyfile.man
	dosed "s:$(INST_DOCS)/gdal:$(INST_DOCS)/html:g" GNUmakefile
	dodoc Doxyfile.man Doxyfile HOWTO-RELEASE NEWS
	if useq doc ; then
	    dohtml html/*.* || die "install html failed"
	fi
}

pkg_postinst() {
	einfo "GDAL is most useful with full graphics support enabled via various"
	einfo "USE flags: png, jpeg, gif, jasper, etc. Also python, fits, ogdi,"
	einfo "geos, and support for either netcdf or HDF4 is available, as well as"
	einfo "grass, and mysql, sqlite, or postgres (grass support requires grass 6)."
	ewarn
	einfo "Note: tiff and geotiff are now hard depends, so no USE flags."
	einfo "Also, this package will check for netcdf before hdf, so if you"
	einfo "prefer hdf, please emerge hdf with USE=szip prior to emerging"
	einfo "gdal.  Detailed API docs require doxygen (man pages are free)."
	einfo ""
	einfo "Check available image and data formats after building with"
	einfo "gdalinfo and ogrinfo (using the --formats switch)."
}

