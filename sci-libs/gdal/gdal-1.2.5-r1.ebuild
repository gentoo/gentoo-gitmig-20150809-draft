# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/gdal/gdal-1.2.5-r1.ebuild,v 1.2 2005/07/11 17:29:37 corsair Exp $

inherit eutils libtool gnuconfig distutils

# libgrass support is coming soon...
#	grass? ( >=sci-geosciences/grass-5.0 )

IUSE="jpeg png gif python postgres mysql ogdi fits debug"

DESCRIPTION="GDAL is a translator library for raster geospatial data formats"
HOMEPAGE="http://www.remotesensing.org/gdal/index.html"
SRC_URI="http://dl.maptools.org/dl/gdal/${P}.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 sparc x86"

DEPEND=">=sys-libs/zlib-1.1.4
	>=media-libs/tiff-3.7.0
	sci-libs/libgeotiff
	jpeg? ( media-libs/jpeg )
	gif? ( media-libs/libungif )
	png? ( media-libs/libpng )
	python? ( dev-lang/python )
	fits? ( sci-libs/cfitsio )
	ogdi? ( sci-libs/ogdi )
	|| (
		sci-libs/netcdf
		sci-libs/hdf
	)
	|| (
		postgres? ( dev-db/postgresql )
		mysql? ( dev-db/mysql )
	)"

src_unpack() {
	unpack ${A}
	cd ${S}
	elibtoolize --patch-only
	gnuconfig_update
}

src_compile() {
	distutils_python_version
	# This package uses old borked automake/autoconf and libtool, so
	# it doesn't work without ${D} (or with econf and einstall).
	pkg_conf="--datadir=${D}usr/share/gdal --includedir=${D}usr/include/gdal --enable-shared --with-gnu-ld --with-pic"
	[ "${ARCH}" = "x86" ] && pkg_conf="${pkg_conf} --without-libtool"
	use_conf="$(use_with jpeg) $(use_with png) $(use_with mysql) $(use_with postgres pg) $(use_with fits cfitsio) $(use_with ogdi)"

	myconf="${pkg_conf} ${use_conf}"

	# These will need version checks:
	#$(use_with grass) $(use_with libgrass)

	if useq gif ; then
		myconf="--with-gif=internal ${myconf}"
	else
		myconf="--with-gif=no ${myconf}"
	fi

	if useq debug ; then
	        export CFG=debug
	fi
#	if useq grass ; then # no libgrass in 5.0.3 !!!
#		myconf="--with-libgrass=/usr/grass5/lib ${myconf}"
#	else
		myconf="--with-libgrass=no ${myconf}"
#	fi

	if useq python ; then
		myconf="--with-pymoddir=${D}usr/lib/python${PYVER}/site-packages ${myconf}"
	else
		myconf="--with-python=no ${myconf}"
	fi

	./configure --prefix=${D}usr --exec-prefix=${D}usr \
	    --with-pymoddir=${D}usr/lib/python${PYVER}/site-packages \
	    ${myconf}
	# Patch libtool here since it's not created until after configure runs
	sed -i -e "s:hardcode_into_libs=yes:hardcode_into_libs=no:g" libtool
	make || die "make failed"
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
	einfo "prefer hdf, please emerge hdf (ver 4 only) prior to emerging"
	einfo "gdal."
}
