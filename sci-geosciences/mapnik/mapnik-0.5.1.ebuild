# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/mapnik/mapnik-0.5.1.ebuild,v 1.7 2009/01/04 19:48:41 mr_bones_ Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A Free Toolkit for developing mapping applications."
HOMEPAGE="http://www.mapnik.org/"
SRC_URI="mirror://berlios/mapnik/mapnik_src-${PV}.tar.gz"
LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="bidi debug doc postgres python xml"

RDEPEND=">=dev-libs/boost-1.33.0
	>=media-libs/libpng-1.2.12
	>=media-libs/jpeg-6b
	>=media-libs/tiff-3.8.2
	>=sys-libs/zlib-1.2.3
	>=media-libs/freetype-2.1.10
	media-fonts/dejavu
	>=sci-libs/proj-4.4.9
	sci-libs/gdal
	xml? ( dev-libs/libxml2 )
	postgres? ( >=dev-db/postgresql-base-8.3
		>=dev-db/postgis-1.1.2 )
	python? ( >=dev-lang/python-2.4 )
	bidi? ( dev-libs/fribidi )"

DEPEND="${RDEPEND}
	>=dev-lang/python-1.5.2
	>=dev-util/scons-0.9.8"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-include-fix.patch

	sed -i -e "s:mapniklibpath + '/fonts':'/usr/share/fonts/dejavu/':g" \
	    bindings/python/SConscript || die "sed 1 failed"
	sed -i -e "s:/usr/local:/usr:g" SConstruct \
	    || die "sed 2 failed"
	sed -i -e "s:SConscript('fonts/SConscript')::g" SConstruct \
	    || die "sed 3 failed"
	rm -rf fonts
	find . -type d -perm /g+s -exec chmod -s '{}' \;

	sed -i -e "s:libraries \= \[:libraries \= \[\'mapnik\',:g" \
	    plugins/input/{gdal,postgis,shape,raster}/SConscript \
	    || die "sed 4 failed"
}

src_compile() {
	MAKEOPTS="INPUT_PLUGINS=all"
	MAKEOPTS="${MAKEOPTS} PROJ_INCLUDES=/usr/include"
	MAKEOPTS="${MAKEOPTS} PROJ_LIBS=/usr/$(get_libdir)"
	MAKEOPTS="${MAKEOPTS} XML2_CONFIG=/usr/bin/xml2-config \
	    XMLPARSER=libxml2"

	if ! use python ; then
	    MAKEOPTS="${MAKEOPTS} BINDINGS=none"
	fi
	if use debug ; then
	    MAKEOPTS="${MAKEOPTS} DEBUG=yes"
	fi
	if use bidi ; then
	    MAKEOPTS="${MAKEOPTS} BIDI=yes"
	fi
	if use postgres ; then
	    MAKEOPTS="${MAKEOPTS} \
		PGSQL_INCLUDES=$(pg_config --includedir)
	        PGSQL_LIBS=$(pg_config --libdir)"
	fi

	scons CXX="$(tc-getCXX)" ${MAKEOPTS} \
	    || die "scons make failed"
}

src_install() {
	scons DESTDIR="${D}" install \
	    || die "scons install failed"

	if use python ; then
	    dobin utils/stats/mapdef_stats.py
	    insinto /usr/share/doc/${P}/examples
	    doins utils/ogcserver/{ogcserver,ogcserver.conf}
	fi

	if use doc ; then
	    dohtml -r docs/epydocs/*
	fi
}

pkg_postinst() {
	elog ""
	elog "See the home page or the OpenStreetMap wiki for more info, and"
	elog "the installed examples for the default mapnik ogcserver config."
	elog ""
}
