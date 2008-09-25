# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/mapnik/mapnik-0.5.1.ebuild,v 1.1 2008/09/25 05:42:05 nerdboy Exp $

inherit eutils autotools

DESCRIPTION="A Free Toolkit for developing mapping applications."
HOMEPAGE="http://www.mapnik.org/"
SRC_URI="mirror://berlios/mapnik/mapnik_src-${PV}.tar.gz"
LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="postgres proj debug doc gdal python bidi"

RDEPEND=">=dev-libs/boost-1.33.0
	>=media-libs/libpng-1.2.12
	>=media-libs/jpeg-6b
	>=media-libs/tiff-3.8.2
	>=sys-libs/zlib-1.2.3
	>=media-libs/freetype-2.1.10
	postgres? ( >=dev-db/postgis-1.1.2 )
	proj? ( >=sci-libs/proj-4.4.9 )
	gdal? ( sci-libs/gdal )
	python? ( >=dev-lang/python-2.4 )
	bidi? ( dev-libs/fribidi )"

DEPEND="${RDEPEND}
	>=dev-lang/python-1.5.2
	>=dev-util/scons-0.9.8"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-include-fix.patch
	sed -i -e "s:/usr/local:/usr:g" SConstruct
	eautoreconf
}

src_compile() {
	if ! use python ; then
		MAKEOPTS="${MAKEOPTS} BINDINGS=none"
	fi
	MAKEOPTS="${MAKEOPTS} INPUT_PLUGINS=shape,raster,postgis"
	if use debug ; then
		MAKEOPTS="${MAKEOPTS} DEBUG=1"
	fi
	if use bidi ; then
		MAKEOPTS="${MAKEOPTS} BIDI=1"
	fi
	if use postgres ; then
		MAKEOPTS="${MAKEOPTS} PGSQL_INCLUDES=/usr/include/postgresql"
	fi
	if use proj ; then
		MAKEOPTS="${MAKEOPTS} PROJ_INCLUDES=/usr/include"
		MAKEOPTS="${MAKEOPTS} PROJ_LIBS=/usr/$(get_libdir)"
	fi
	MAKEOPTS="${MAKEOPTS} XMLPARSER=libxml2"
	scons ${MAKEOPTS} || die
}

src_install() {
	scons ${MAKEOPTS} DESTDIR="${D}" install || die "Unable to install Mapnik"
	if use doc ; then
		dohtml -r docs/epydocs/*
	fi
}
