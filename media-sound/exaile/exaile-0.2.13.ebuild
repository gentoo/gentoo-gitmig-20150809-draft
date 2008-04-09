# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/exaile/exaile-0.2.13.ebuild,v 1.2 2008/04/09 13:26:21 drac Exp $

EAPI=1

inherit eutils fdo-mime multilib python

GVER=0.10

MY_P=${PN}_${PV}

DESCRIPTION="a media player aiming to be similar to AmaroK, but for GTK+"
HOMEPAGE="http://www.exaile.org"
SRC_URI="http://www.exaile.org/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE="aac alsa cdparanoia equalizer flac gnome ipod +jpeg libnotify +libsexy
	mad musepack nls ogg oss +png vorbis"

RDEPEND="dev-python/dbus-python
	>=media-libs/mutagen-1.12
	>=dev-python/pygtk-2.10
	|| ( >=dev-lang/python-2.5 >=dev-python/pysqlite-2.3.5 )
	|| ( >=dev-lang/python-2.5 dev-python/elementtree )
	libnotify? ( dev-python/notify-python )
	libsexy? ( dev-python/sexy-python )
	gnome? ( >=dev-python/gnome-python-extras-2.14
		>=media-plugins/gst-plugins-gconf-${GVER}
		>=media-plugins/gst-plugins-gnomevfs-${GVER} )
	>=media-libs/gst-plugins-good-${GVER}
	equalizer? ( >=media-libs/gst-plugins-bad-0.10.5 )
	>=dev-python/gst-python-0.10.9
	musepack? ( >=media-plugins/gst-plugins-musepack-${GVER} )
	vorbis? ( >=media-plugins/gst-plugins-vorbis-${GVER} )
	flac? ( >=media-plugins/gst-plugins-flac-${GVER} )
	aac? ( >=media-plugins/gst-plugins-faad-${GVER} )
	alsa? ( >=media-plugins/gst-plugins-alsa-${GVER} )
	oss? ( >=media-plugins/gst-plugins-oss-${GVER} )
	mad? ( >=media-plugins/gst-plugins-mad-${GVER} )
	ogg? ( >=media-plugins/gst-plugins-ogg-${GVER} )
	cdparanoia? ( >=media-plugins/gst-plugins-cdparanoia-${GVER}
		dev-python/cddb-py )
	ipod? ( >=media-libs/libgpod-0.4
		>=media-plugins/gst-plugins-faad-${GVER} )
	jpeg? ( >=media-plugins/gst-plugins-jpeg-${GVER} )
	png? ( >=media-plugins/gst-plugins-libpng-${GVER} )"
DEPEND="nls? ( dev-util/intltool sys-devel/gettext )"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	if use ipod && ! built_with_use media-libs/libgpod python; then
		die "Re-emerge media-libs/libgpod with USE python."
	fi

	if ! has_version ">=dev-python/pysqlite-2.3.4-r1"; then
		if ! built_with_use ">=dev-lang/python-2.5" sqlite; then
			die "Re-emerge dev-lang/python with USE sqlite."
		fi
	fi
}

src_compile() {
	emake mmkeys.so || die "emake mmkeys.so failed."

	if use nls; then
		emake translations || die "emake translations failed."
	fi
}

src_install() {
	emake PREFIX="/usr" LIBDIR="/$(get_libdir)" DESTDIR="${D}" install || die "emake install failed."
	newdoc changelog ChangeLog
}

pkg_postinst() {
	python_mod_optimize "${ROOT}"usr/$(get_libdir)/${PN}
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	elog "You need media-plugins/gst-plugins-gnomevfs for streaming, but you may also try"
	elog "media-plugins/gst-plugins-neon to avoid installing gnome."
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/${PN}
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
