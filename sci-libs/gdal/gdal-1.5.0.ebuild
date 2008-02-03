# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/gdal/gdal-1.5.0.ebuild,v 1.1 2008/02/03 23:00:39 nerdboy Exp $

inherit autotools distutils eutils perl-module toolchain-funcs

IUSE="debug doc fits geos gif gml hdf hdf5 jpeg jpeg2k mysql netcdf \
	odbc png ogdi perl postgres python ruby sqlite"

DESCRIPTION="GDAL is a translator library for raster geospatial data formats (includes OGR support)"
HOMEPAGE="http://www.gdal.org/"
SRC_URI="http://download.osgeo.org/gdal/${P}.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
# need to get these arches updated on several libs first
#KEYWORDS="~alpha ~hppa"

DEPEND=">=sys-libs/zlib-1.1.4
	>=media-libs/tiff-3.7.0
	sci-libs/libgeotiff
	jpeg? ( media-libs/jpeg )
	gif? ( media-libs/giflib )
	png? ( media-libs/libpng )
	perl? ( dev-lang/perl )
	python? ( virtual/python
		dev-python/numpy )
	ruby? ( >=dev-lang/ruby-1.8.4.20060226
		>=dev-lang/swig-1.3.28 )
	fits? ( sci-libs/cfitsio )
	ogdi? ( sci-libs/ogdi )
	gml? ( >=dev-libs/xerces-c-2.8.0 )
	hdf5? ( >=sci-libs/hdf5-1.6.4 )
	postgres? ( dev-db/postgresql )
	|| (
	    netcdf? ( sci-libs/netcdf )
	    hdf? ( sci-libs/hdf )
	)
	jpeg2k? ( media-libs/jasper )
	mysql? ( virtual/mysql )
	odbc?   ( dev-db/unixODBC )
	geos?   ( >=sci-libs/geos-2.2.1 )
	sqlite? ( >=dev-db/sqlite-3 )
	doc? ( app-doc/doxygen )"

WANT_AUTOCONF="2.5"
AT_M4DIR="${S}/m4"

src_unpack() {
	unpack ${A}
	cd "${S}"

	eaclocal
	eautoconf

	epatch "${FILESDIR}/${PN}-1.4.2-datadir.patch" \
	    "${FILESDIR}/${P}-python-install.patch" \
	    "${FILESDIR}/${P}-soname.patch" \
	    "${FILESDIR}/${P}-makefile.patch"

	if useq netcdf && useq hdf; then
	    einfo	"Checking if HDF4 is compiled with szip..."
	    if built_with_use sci-libs/hdf szip ; then
		einfo	"Found HDF4 compiled with szip. Nice."
	    else
		ewarn 	"HDF4 (sci-libs/hdf) must be compiled with the szip USE flag!"
		einfo 	"Please emerge hdf with szip USE flag and then emerge GDAL."
		die 	"HDF4 not merged with szip use flag"
	    fi
	fi
}

src_compile() {
	distutils_python_version

	pkg_conf="--enable-static=no --enable-shared=yes --with-pic \
		--with-libgrass=no --without-libtool $(use_enable debug)"

	use_conf="$(use_with jpeg) $(use_with png) $(use_with mysql) \
	    $(use_with perl) $(use_with python) $(use_with ruby) \
	    $(use_with postgres pg) $(use_with fits cfitsio) \
	    $(use_with netcdf) $(use_with hdf hdf4) $(use_with geos) \
	    $(use_with sqlite) $(use_with jpeg2k jasper) $(use_with odbc) \
	    $(use_with gml xerces) $(use_with hdf5)"

	# It can't find this
	if useq ogdi ; then
	    use_conf="--with-ogdi=/usr/$(get_libdir) ${use_conf}"
	fi

	if useq mysql ; then
	    use_conf="--with-mysql=/usr/bin/mysql_config ${use_conf}"
	fi

	if useq gif ; then
	    use_conf="--with-gif=internal ${use_conf}"
	else
	    use_conf="--with-gif=no ${use_conf}"
	fi

	if useq python ; then
	    use_conf="--with-pymoddir=/usr/$(get_libdir)/python${PYVER}/site-packages \
		${use_conf}"
	fi

	# Fix doc path just in case
	sed -i -e "s:@exec_prefix@/doc:/usr/share/doc/${PF}/html:g" GDALmake.opt.in

	econf ${pkg_conf} ${use_conf} || die "econf failed"

	# parallel makes fail on the ogr stuff (C++, what can I say?)
	# also failing with gcc4 in libcsf
	emake -j1 || die "emake failed"

	if use python; then
	    sed -i -e "s#library_dirs = #library_dirs = /usr/$(get_libdir):#g" \
		swig/python/setup.cfg
	    sed -i -e "s:$(DESTDIR)$(prefix):$(DESTDIR)$(INST_PREFIX):g" \
		swig/python/GNUmakefile
	fi

	if useq perl ; then
	    cd "${S}"/swig/perl
	    perl-module_src_prep
	    perl-module_src_compile
	    cd "${S}"
	fi

	if useq doc ; then
	    make docs || die "make docs failed"
	fi
}

src_install() {

	if useq perl; then
	    cd "${S}"/swig/perl
	    perl-module_src_install
	    sed -i -e "s:BINDINGS        =       python ruby perl:BINDINGS        =       python ruby:g" \
		GDALmake.opt
	    cd "${S}"
	fi

	# einstall causes sandbox violations on /usr/lib/libgdal.so
	make DESTDIR="${D}" install \
	    || die "make install failed"

	dodoc Doxyfile HOWTO-RELEASE NEWS

	if useq doc ; then
	    dohtml html/* || die "install html failed"
	    docinto ogr
	    dohtml ogr/html/* || die "install ogr html failed"
	fi

	if useq python; then
	    newdoc swig/python/README.txt README-python.txt
	    dodir /usr/share/${PN}/samples
	    insinto /usr/share/${PN}/samples
	    doins swig/python/samples/*
	fi
}

pkg_postinst() {
	einfo "GDAL is most useful with full graphics support enabled via various"
	einfo "USE flags: png, jpeg, gif, jpeg2k, etc. Also python, fits, ogdi,"
	einfo "geos, and support for either netcdf or HDF4 is available, as well as"
	einfo "grass, and mysql, sqlite, or postgres (grass support requires grass 6"
	einfo "and the new gdal-grass ebuild).  HDF5 support is now included."
	ewarn
	einfo "Note: tiff and geotiff are now hard depends, so no USE flags."
	einfo "Also, this package will check for netcdf before hdf, so if you"
	einfo "prefer hdf, please emerge hdf with USE=szip prior to emerging"
	einfo "gdal.  Detailed API docs require doxygen (man pages are free)."
	einfo ""
	einfo "Check available image and data formats after building with"
	einfo "gdalinfo and ogrinfo (using the --formats switch)."
}
