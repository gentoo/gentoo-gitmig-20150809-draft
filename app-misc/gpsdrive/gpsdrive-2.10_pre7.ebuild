# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gpsdrive/gpsdrive-2.10_pre7.ebuild,v 1.1 2009/06/24 08:05:08 tupone Exp $
EAPI=2

inherit cmake-utils eutils fdo-mime

DESCRIPTION="GPS navigation system with NMEA and Garmin support, zoomable map display, waypoints, etc."
HOMEPAGE="http://www.gpsdrive.de/"
SRC_URI="${HOMEPAGE}/packages/${P/_/}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

S=${WORKDIR}/${P/_/}

KEYWORDS="~amd64 ~ppc ~x86"
# submit bug for ppc64

IUSE="dbus debug libgda gdal mapnik scripts speech"

COMMON_DEP="sci-geosciences/gpsd
	net-misc/curl
	dev-libs/libxml2
	dev-db/sqlite:3
	x11-libs/gtk+:2
	dbus? ( dev-libs/dbus-glib )
	gdal? ( sci-libs/gdal )
	mapnik? ( sci-geosciences/mapnik )
	libgda? ( >=gnome-extra/libgda-3.0.1[postgres] )
	speech? ( app-accessibility/speech-dispatcher )"

DEPEND="${COMMON_DEP}
	dev-util/pkgconfig"

RDEPEND="${COMMON_DEP}
	sci-geosciences/openstreetmap-icons
	sci-geosciences/mapnik-world-boundaries
	media-fonts/dejavu"

src_prepare() {
	# Update mapnik font path...
	sed -i \
		-e "s:truetype/ttf-dejavu:dejavu:g" \
		-e "s:mapnik/0.5:mapnik:g" \
	    tests/gpsdriverc-in \
	    src/gpsdrive_config.c || die "sed failed"
	# Fix desktop file...
	sed -i -e "s:gpsicon:/usr/share/gpsdrive/pixmaps/gpsicon.png:g" \
	    -e "s:Graphics;Network;Geography:Application;Geography;GPS:g" \
	    data/gpsdrive.desktop || die "sed failed"
}

src_configure() {
	local mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with scripts SCRIPTS)
		$(cmake-utils_use_with mapnik MAPNIK)
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
		elog "Using mapnik to render online map require you to"
		elog "load data into the postgis database. Follow instructions"
		elog "on http://wiki.openstreetmap.org/index.php/Mapnik"
	fi
	elog
	elog "This version also now depends on the gpsd package, and"
	elog "specific devices are supported there.  Start gpsd first,"
	elog "otherwise gpsdrive will only run in simulation mode (which"
	elog "is handy for downloading maps for another location, but"
	elog "not much else)."
	elog
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
