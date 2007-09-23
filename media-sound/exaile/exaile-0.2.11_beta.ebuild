# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/exaile/exaile-0.2.11_beta.ebuild,v 1.2 2007/09/23 16:07:20 drac Exp $

inherit eutils fdo-mime multilib python

GVER="0.10"

MY_P=${PN}_${PV/_beta/b}

DESCRIPTION="a media player aiming to be similar to AmaroK, but for GTK+"
HOMEPAGE="http://www.exaile.org"
SRC_URI="http://www.exaile.org/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="aac alsa cdparanoia equalizer flac gnome ipod libnotify libsexy mad musepack ogg
	oss vorbis"

RDEPEND=">=dev-python/pygtk-2.8.6
	|| ( >=dev-lang/python-2.5 >=dev-python/pysqlite-2.3.4-r1 )
	>=media-libs/mutagen-1.6
	|| ( >=dev-lang/python-2.5 dev-python/elementtree )
	dev-python/dbus-python
	libnotify? ( dev-python/notify-python )
	libsexy? ( dev-python/sexy-python )
	gnome? ( >=dev-python/gnome-python-extras-2.14.2-r1
		>=media-plugins/gst-plugins-gconf-${GVER}
		>=media-plugins/gst-plugins-gnomevfs-${GVER} )
	>=media-libs/gstreamer-${GVER}
	>=media-libs/gst-plugins-good-${GVER}
	equalizer? ( >=media-libs/gst-plugins-bad-0.10.5 )
	>=dev-python/gst-python-${GVER}
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
		>=media-plugins/gst-plugins-faad-${GVER} )"
DEPEND=""

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if use ipod && ! built_with_use media-libs/libgpod python ; then
		eerror "libgpod has to be built with python support"
		die "libgpod python use-flag not set"
	fi

	if ! has_version ">=dev-python/pysqlite-2.3.4-r1"; then
		if ! built_with_use ">=dev-lang/python-2.5" sqlite; then
			eerror "You need to compile dev-lang/python with USE sqlite, or"
			eerror "install >=dev-python/pysqlite-2.3.4-r1."
			die "python 2.5 or up with sqlite support or pysqlite 2.3.5 or up required."
		fi
	fi

	if use gnome; then
		if ! built_with_use dev-python/gnome-python-extras xulrunner; then
			if ! built_with_use dev-python/gnome-python-extras firefox; then
				if ! built_with_use dev-python/gnome-python-extras seamonkey; then
					ewarn "In order to enable extra features provided by gtkmozembed,"
					ewarn "you have to re-emerge gnome-python-extras with"
					ewarn "xulrunner, firefox or seamonkey USE flag."
					epause
				fi
			fi
		fi
	fi
}

src_compile() {
	emake mmkeys.so || die "emake mmkeys.so failed."
	emake translations || die "emake translations failed."
}

src_install() {
	emake PREFIX="/usr" LIBDIR="/$(get_libdir)" DESTDIR="${D}" install || die "emake install failed."
	dodoc changelog TODO
}

pkg_postinst() {
	python_mod_optimize /usr/$(get_libdir)/${PN}
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/${PN}
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
