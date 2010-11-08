# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/mapnik/mapnik-0.6.1-r3.ebuild,v 1.3 2010/11/08 17:30:15 xarthisius Exp $

EAPI=2
PYTHON_DEPEND="2:2.6"

inherit eutils python distutils toolchain-funcs versionator

DESCRIPTION="A Free Toolkit for developing mapping applications."
HOMEPAGE="http://www.mapnik.org/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="cairo curl debug doc +gdal postgres python sqlite"

RDEPEND="=dev-libs/boost-1.39*
	dev-libs/libxml2
	dev-libs/icu
	media-libs/libpng
	virtual/jpeg
	media-libs/tiff
	media-libs/freetype:2
	sci-libs/proj
	x11-libs/agg[gpc,truetype]
	media-fonts/dejavu
	python? ( =dev-libs/boost-1.39*[python] )
	cairo? ( x11-libs/cairo
		dev-cpp/cairomm )
	postgres? (
		>=dev-db/postgresql-base-8.0
		>=dev-db/postgis-1.1.2
	)
	gdal? ( sci-libs/gdal )
	sqlite? ( dev-db/sqlite:3 )
	curl? ( net-misc/curl )"

DEPEND="${RDEPEND}
	>=dev-util/scons-1.0.0"

src_prepare() {
	sed -i -e "s|/usr/local|/usr|g" \
		-e "s|Action(env\[config\]|Action('%s --help' % env\[config\]|" \
		SConstruct || die

	sed -i -e "s:mapniklibpath + '/fonts':'/usr/share/fonts/dejavu/':g" \
	    bindings/python/SConscript || die "sed 1 failed"
	rm -rf agg
	epatch "${FILESDIR}"/${P}-libagg.patch

	BOOST_PKG="$(best_version "<dev-libs/boost-1.40.0")"
	BOOST_VER="$(get_version_component_range 1-2 "${BOOST_PKG/*boost-/}")"
	export BOOST_VERSION="$(replace_all_version_separators _ "${BOOST_VER}")"
	elog "${P} BOOST_VERSION is ${BOOST_VERSION}"
	export BOOST_INC="/usr/include/boost-${BOOST_VERSION}"
	elog "${P} BOOST_INC is ${BOOST_INC}"
	BOOST_LIBDIR_SCHEMA="$(get_libdir)/boost-${BOOST_VERSION}"
	export BOOST_LIB="/usr/${BOOST_LIBDIR_SCHEMA}"
	elog "${P} BOOST_LIB is ${BOOST_LIB}"

	# Passing things doesn't seem to hit all the right paths; another
	# poster-child for just a bit too much complexity for its own good.
	# See bug #301674 for more info.
	sed -i -e "s|searchDir, LIBDIR_SCHEMA|searchDir, \'${BOOST_LIBDIR_SCHEMA}\'|" \
		-i -e "s|include/boost*|include/boost-${BOOST_VERSION}|" \
		"${S}"/SConstruct || die "sed boost paths failed..."

	# this is only for 1.37
#	sed -i -e "s|libboost_filesystem-|libboost_filesystem-mt|" \
#		"${S}"/SConstruct || die "sed boost 1.37 failed..."
	# this is only for boost greater than 1.39
#	sed -i -e "s|boost/property|boost/property_map/property|" \
#		"${S}"/include/mapnik/feature.hpp
}

src_configure() {
	MAKEOPTS="SYSTEM_FONTS=/usr/share/fonts/dejavu"

	MAKEOPTS="${MAKEOPTS} INPUT_PLUGINS="
	use postgres && MAKEOPTS="${MAKEOPTS}postgis,"
	use gdal     && MAKEOPTS="${MAKEOPTS}gdal,ogr,"
	use sqlite   && MAKEOPTS="${MAKEOPTS}sqlite,"
	use curl     && MAKEOPTS="${MAKEOPTS}osm,"
	MAKEOPTS="${MAKEOPTS}shape,raster"

	use cairo  || MAKEOPTS="${MAKEOPTS} CAIRO=false"
	use python || MAKEOPTS="${MAKEOPTS} BINDINGS=none"
	use debug  && MAKEOPTS="${MAKEOPTS} DEBUG=yes"

	use postgres && use sqlite && MAKEOPTS="${MAKEOPTS} PGSQL2SQLITE=yes"

	scons CXX="$(tc-getCXX)" ${MAKEOPTS} DESTDIR="${D}" \
		BOOST_INCLUDES=${BOOST_INC} BOOST_LIBS=${BOOST_LIB} \
		configure || die "scons configure failed"
}

src_compile() {
	scons BOOST_INCLUDES=${BOOST_INC} BOOST_LIBS=${BOOST_LIB} \
		BOOST_VERSION=${BOOST_VERSION} || die "scons make failed"
}

src_install() {
	scons BOOST_INCLUDES=${BOOST_INC} BOOST_LIBS=${BOOST_LIB} \
		BOOST_VERSION=${BOOST_VERSION} install \
		|| die "scons install failed"

	if use python ; then
	    fperms 0755 $(python_get_sitedir)/mapnik/paths.py
	    dobin utils/stats/mapdef_stats.py
	    insinto /usr/share/doc/${P}/examples
	    doins utils/ogcserver/*
	fi

	dodoc AUTHORS CHANGELOG README
	use doc && dohtml -r docs/api_docs/python/*
}

pkg_postinst() {
	elog ""
	elog "See the home page or the OpenStreetMap wiki for more info, and"
	elog "the installed examples for the default mapnik ogcserver config."
	elog ""
}
