# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/mapnik/mapnik-2.0.0.ebuild,v 1.5 2012/05/24 12:22:37 scarabeus Exp $

EAPI=3

PYTHON_DEPEND="python? 2"
inherit eutils python scons-utils toolchain-funcs

DESCRIPTION="A Free Toolkit for developing mapping applications."
HOMEPAGE="http://www.mapnik.org/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="bidi cairo debug doc gdal geos nobfonts postgres python sqlite"

RDEPEND="net-misc/curl
	media-libs/libpng
	media-libs/jpeg
	media-libs/tiff
	sys-libs/zlib
	media-libs/freetype
	dev-lang/python
	sci-libs/proj
	dev-libs/libxml2
	dev-libs/icu
	x11-libs/agg[truetype]
	>=dev-libs/boost-1.48[python?]
	postgres? ( >=dev-db/postgresql-base-8.3 )
	gdal? ( sci-libs/gdal )
	geos? ( sci-libs/geos )
	bidi? ( dev-libs/fribidi )
	cairo? (
		x11-libs/cairo
		dev-cpp/cairomm
		python? ( dev-python/pycairo )
	)
	sqlite? ( dev-db/sqlite:3 )
	nobfonts? ( media-fonts/dejavu )"

DEPEND="${RDEPEND}
	doc? ( dev-python/epydoc )
	dev-util/scons"

#EPATCH_OPTS="-F 3"

pkg_setup() {
	if use python; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
}

src_configure() {
	local PLUGINS=shape,raster,osm
	use gdal && PLUGINS+=,gdal,ogr
	use geos && PLUGINS+=,geos
	use postgres && PLUGINS+=,postgis
	use sqlite && PLUGINS+=,sqlite

	SCONOPTS="
		CC=$(tc-getCC)
		CXX=$(tc-getCXX)
		INPUT_PLUGINS=${PLUGINS}
		PREFIX=/usr
		XMLPARSER=libxml2
		PROJ_INCLUDES=/usr/include
		PROJ_LIBS=/usr/lib
		$(use_scons nobfonts SYSTEM_FONTS /usr/share/fonts '')
		$(use_scons python BINDINGS all none)
		$(use_scons python BOOST_PYTHON_LIB boost_python-${PYTHON_ABI})
		$(use_scons bidi BIDI)
		$(use_scons cairo CAIRO)
		$(use_scons debug DEBUG)
		$(use_scons debug XML_DEBUG)
		$(use_scons doc DEMO)
		$(use_scons doc SAMPLE_INPUT_PLUGINS)
		CUSTOM_LDFLAGS=${LDFLAGS}
		CUSTOM_LDFLAGS+=-L${D}/usr/$(get_libdir)"

	# force user flags, optimization level
	sed -i -e "s:\-O%s:${CXXFLAGS}:" \
		-i -e "s:env\['OPTIMIZATION'\]\,::" \
		SConstruct || die "sed 3 failed"

	scons $SCONOPTS configure || die "scons configure failed"
}

src_compile() {
	scons ${MAKEOPTS} shared=1 || die "scons compile failed"
}

src_install() {
	#the lib itself still seems to need a DESTDIR definition
	scons DESTDIR="${D}" install || die "scons install failed"

	if use python ; then
		fperms 0644 "$(python_get_sitedir)"/mapnik2/paths.py
		dobin utils/stats/mapdef_stats.py
		insinto /usr/share/doc/${PF}/examples
		doins utils/ogcserver/*
	fi

	dodoc AUTHORS README || die

	# this is known to depend on mod_python and should not have a
	# "die" after the epydoc script (see bug #370575)
	if use doc; then
		export PYTHONPATH="${D}$(python_get_sitedir):$(python_get_sitedir)"
		pushd docs/epydoc_config > /dev/null
			./build_epydoc.sh
		popd > /dev/null
		dohtml -r docs/api_docs/python/* || die "API doc install failed"
	fi
}

pkg_postinst() {
	elog ""
	elog "See the home page or wiki (http://trac.mapnik.org/) for more info"
	elog "or the installed examples for the default mapnik ogcserver config."
	elog ""
}
