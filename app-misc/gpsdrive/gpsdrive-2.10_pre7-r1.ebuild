# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gpsdrive/gpsdrive-2.10_pre7-r1.ebuild,v 1.5 2011/03/21 21:04:05 nirbheek Exp $

EAPI=2

inherit cmake-utils eutils fdo-mime versionator

DESCRIPTION="GPS navigation system with NMEA and Garmin support, zoomable map display, waypoints, etc."
HOMEPAGE="http://www.gpsdrive.de/"
SRC_URI="${HOMEPAGE}/packages/${P/_/}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

S=${WORKDIR}/${P/_/}

KEYWORDS="~amd64 ~ppc ~x86"
# submit bug for ppc64

IUSE="dbus -debug -kismet libgda gdal mapnik scripts -speech"

COMMON_DEP="sci-geosciences/gpsd
	net-misc/curl
	dev-libs/libxml2:2
	dev-db/sqlite:3
	x11-libs/gtk+:2
	dbus? ( dev-libs/dbus-glib )
	gdal? ( sci-libs/gdal )
	kismet? ( net-wireless/kismet )
	mapnik? ( >=sci-geosciences/mapnik-0.6.1
		=dev-libs/boost-1.39*
		>=app-admin/eselect-boost-0.3 )
	libgda? ( =gnome-extra/libgda-3.0*:3[postgres] )
	speech? ( >=app-accessibility/speech-dispatcher-0.6.7 )"

DEPEND="${COMMON_DEP}
	>=dev-util/cmake-2.8.0
	dev-util/pkgconfig"

RDEPEND="${COMMON_DEP}
	sci-geosciences/openstreetmap-icons
	sci-geosciences/mapnik-world-boundaries
	media-fonts/dejavu"

pkg_setup() {
	BOOST_PKG="$(best_version "<dev-libs/boost-1.40.0")"
	BOOST_VER="$(get_version_component_range 1-2 "${BOOST_PKG/*boost-/}")"
	export Boost_LIB_VERSION="$(replace_all_version_separators _ "${BOOST_VER}")"
	elog "${P} Boost_LIB_VERSION is ${Boost_LIB_VERSION}"
	export BOOST_INCLUDEDIR="/usr/include/boost-${Boost_LIB_VERSION}"
	elog "${P} BOOST_INCLUDEDIR is ${BOOST_INCLUDEDIR}"
	BOOST_LIBDIR_SCHEMA="$(get_libdir)/boost-${Boost_LIB_VERSION}"
	export BOOST_LIBRARYDIR="/usr/${BOOST_LIBDIR_SCHEMA}"
	elog "${P} BOOST_LIBRARYDIR is ${BOOST_LIBRARYDIR}"
}

src_prepare() {
	# Get rid of the package's FindBoost (see bug #).
	rm "${S}"/cmake/Modules/FindBoost.cmake

	# Update mapnik font path...
	sed -i \
		-e "s:truetype/ttf-dejavu:dejavu:g" \
		-e "s:mapnik/0.5:mapnik:g" \
	    tests/gpsdriverc-in \
	    src/gpsdrive_config.c || die "sed failed"

	# update OSM icon paths
	sed -i \
		-e "s|icons/map-icons|osm|g" \
	    cmake/Modules/DefineInstallationPaths.cmake \
	    scripts/osm/perl_lib/Geo/Gpsdrive/DB_Defaults.pm \
	    scripts/osm/perl_lib/Geo/Gpsdrive/OSM.pm \
	    src/icons.c \
	    || die "sed failed"

	# Fix desktop file...
	sed -i -e "s:gpsicon:/usr/share/icons/gpsdrive.png:g" \
	    -e "s:Graphics;Network;Geography:Education;Science;Geography;GPS:g" \
	    data/gpsdrive.desktop || die "sed failed"
}

src_configure() {
	cat >> cmake/Modules/DefineProjectDefaults.cmake <<- _EOF_

		# set policy for new linker paths
		cmake_policy(SET CMP0003 NEW) # or cmake_policy(VERSION 2.6)
	_EOF_

	local mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with scripts SCRIPTS)
		$(cmake-utils_use_with mapnik MAPNIK)
		$(cmake-utils_use_with kismet KISMET)
		$(cmake-utils_use_with dbus DBUS)
		$(cmake-utils_use_with libgda GDA3)
		$(cmake-utils_use_with speech SPEECH)
		$(cmake-utils_use_with gdal GDAL)"
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dodoc AUTHORS ChangeLog README \
		Documentation/{CREDITS.i18n,FAQ.gpsdrive,FAQ.gpsdrive.fr,LEEME} \
		Documentation/{LISEZMOI,NMEA.txt,LISEZMOI.kismet,TODO} \
		Documentation/README.{Bluetooth,lib_map,nasamaps,tracks,kismet}
	if use mapnik ; then
		dodoc Documentation/install-mapnik-osm.txt
	else
	    rm -f "${D}"usr/bin/gpsdrive_mapnik_gentiles.py
	    rm -f "${D}"usr/share/gpsdrive/osm-template.xml
	fi
	if use scripts ; then
		dodoc Documentation/README.gpspoint2gspdrive
		if ! use gdal ; then
			rm -f "${D}"usr/bin/{gdal_slice,nasaconv}.sh
		fi
	else
		rm -f "${D}"usr/share/man/man1/gpsd_nmea.sh.1
	fi
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	elog
	elog "Be sure to see the README files in /usr/share/doc/${PF}"
	elog "for information on using Kismet with gpsdrive."
	elog
	if use mapnik ; then
		elog "Using mapnik to render online maps requires you to load"
		elog "data into the postgis database. Follow the instructions"
		elog "on http://wiki.openstreetmap.org/index.php/Mapnik"
	fi
	elog
	elog "This version also now depends on the gpsd package, and"
	elog "specific devices are supported there.  Start gpsd first,"
	elog "otherwise gpsdrive will only run in simulation mode (which"
	elog "is handy for downloading maps for another location, but"
	elog "not much else)."
	elog
	elog "openstreetmap-icons now installs to a more appropriate"
	elog "location, so if you have trouble starting gpsdrive, you"
	elog "should probably update your ~/.gpsdrive/gpsdriverc file"
	elog "and change the path to the geoinfofile to reflect this:"
	elog "   geoinfofile = /usr/share/osm/geoinfo.db"
	elog
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
