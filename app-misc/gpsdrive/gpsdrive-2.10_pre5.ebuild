# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gpsdrive/gpsdrive-2.10_pre5.ebuild,v 1.4 2008/12/07 20:38:20 nerdboy Exp $

inherit cmake-utils eutils fdo-mime

DESCRIPTION="GPS navigation system with NMEA and Garmin support, zoomable map display, waypoints, etc."
HOMEPAGE="http://www.gpsdrive.de/"
SRC_URI="${HOMEPAGE}/packages/${P/_/}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

S=${WORKDIR}/${P/_/}

KEYWORDS="~amd64 ~ppc ~x86"
# submit bug for ppc64

IUSE="dbus debug doc gdal mapnik scripts"

COMMON_DEP=">=x11-libs/gtk+-2.8.12
	>=media-libs/libart_lgpl-2.3.17
	>=media-libs/fontconfig-2.2.3
	>=x11-libs/libXcursor-1.1.2
	>=dev-libs/atk-1.10.3
	>=dev-libs/libpcre-4.2
	>=dev-libs/boost-1.33.1
	>=gnome-extra/libgda-3.0.1
	>=x11-libs/pango-1.10.1
	>=dev-libs/glib-2.8.5
	>=x11-libs/cairo-1.0.2
	dbus? ( sys-apps/dbus )
	mapnik? ( >=sci-geosciences/mapnik-0.5 )
	gdal? ( sci-libs/gdal )"

DEPEND="${COMMON_DEP}
	>=dev-util/cmake-2.4.4
	sys-devel/gettext
	dev-util/pkgconfig"

RDEPEND="${COMMON_DEP}
	dev-perl/libwww-perl
	dev-perl/DBI
	sci-geosciences/gpsd
	media-fonts/dejavu"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# The utils won't build without some extra functions that
	# aren't implemented yet AFAICT; temporarily disabled.
	epatch "${FILESDIR}"/${PN}-drawmarkers-remove.patch
	# Update mapnik font path...
	use mapnik && ( sed -i -e "s:truetype/ttf-dejavu:dejavu:g" \
	    tests/{gpsdriverc,gpsdriverc-in,gpsdriverc-pre} \
	    src/gpsdrive_config.c || die "sed failed" )
	# Fix desktop file...
	sed -i -e "s:gpsicon:/usr/share/gpsdrive/pixmaps/gpsicon.png:g" \
	    -e "s:Graphics;Network;Geography:Application;Geography;GPS:g" \
	    data/gpsdrive.desktop || die "sed failed"
}

src_compile() {
	local mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with scripts SCRIPTS)
		$(cmake-utils_use_with mapnik MAPNIK)
		$(cmake-utils_use_with dbus DBUS)
		$(cmake-utils_use_with gdal GDAL)"
	cmake-utils_src_configure
	cmake-utils_src_make -j1
}

src_install() {
	cmake-utils_src_install
	dodoc AUTHORS ChangeLog NEWS README
	newdoc data/mysql/my.cnf my.cnf.example
	if use mapnik ; then
	    dodoc Documentation/install-mapnik-osm.txt
	else
	    rm -f "${D}"usr/bin/{gpsdrive_mapnik_gentiles.py,gpsdrive-update-mapnik-poitypes.pl}
	fi
	use doc && dodoc \
	    Documentation/{FAQ.gpsdrive,CREDITS,GPS-receivers,LEEME,NMEA.txt,TODO,README*}
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	elog
	elog "Be sure to see the README files in /usr/share/doc/${PF}"
	elog "for information on using Kismet with gpsdrive. The MySQL"
	elog "config is installed as an example, but using it with"
	elog "gpsdrive is up to you.  Additional scripts are still"
	elog "shipped in the source package."
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
