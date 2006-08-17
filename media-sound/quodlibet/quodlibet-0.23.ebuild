# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/quodlibet/quodlibet-0.23.ebuild,v 1.1 2006/08/17 12:19:49 tcort Exp $

inherit eutils python

DESCRIPTION="Quod Libet is a GTK+-based audio player written in Python."
HOMEPAGE="http://www.sacredchao.net/quodlibet/"
SRC_URI="http://www.sacredchao.net/~piman/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="aac alsa dbus esd flac gnome mad mmkeys musepack oss trayicon vorbis"

DEPEND=">=virtual/python-2.4.3-r1
	trayicon? ( >=dev-python/pygtk-2.8 )
	mmkeys? ( >=dev-python/pygtk-2.8 )"

RDEPEND="${DEPEND}
	>=dev-python/pygtk-2.8
	>=media-libs/mutagen-1.6
	>=media-libs/gst-plugins-good-0.10.2
	>=dev-python/gst-python-0.10.2
	>=media-plugins/gst-plugins-gconf-0.10.3
	mad? ( >=media-plugins/gst-plugins-mad-0.10.2 )
	vorbis? ( >=media-plugins/gst-plugins-vorbis-0.10.2
		>=media-plugins/gst-plugins-ogg-0.10.2 )
	flac? ( >=media-plugins/gst-plugins-flac-0.10.2 )
	aac? ( >=media-plugins/gst-plugins-faad-0.10.1
		>=dev-python/ctypes-0.9.9.6 )
	musepack? ( >=media-plugins/gst-plugins-musepack-0.10.0
		>=dev-python/ctypes-0.9.9.6 )
	alsa? ( >=media-plugins/gst-plugins-alsa-0.10.2 )
	oss? ( >=media-plugins/gst-plugins-oss-0.10.2 )
	esd? ( >=media-plugins/gst-plugins-esd-0.10.2 )
	gnome? ( dev-python/gnome-python-extras
		>=media-plugins/gst-plugins-gnomevfs-0.10.2
		dev-python/feedparser )
	dbus? ( >=sys-apps/dbus-0.62 )"

PDEPEND="trayicon? ( media-plugins/quodlibet-trayicon )"

pkg_setup() {
	if use dbus && ! built_with_use sys-apps/dbus python ; then
		eerror "dbus is missing python support. Please add 'python'"
		eerror "to your USE flags, and re-emerge sys-apps/dbus"
		die "dbus needs python support"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}"/${PN}-0.17.1-multilibfix.patch
}

src_compile() {
	if use trayicon ; then
		emake _trayicon.so || die "emake _trayicon.so failed"
	fi
	if use mmkeys ; then
		emake _mmkeys.so   || die "emake _mmkeys.so failed"
	fi
}

src_install() {
	emake PREFIX=/usr DESTDIR="${D}" libdir="$(get_libdir)" install ||
		die "install failed"
	dodoc README NEWS
}

pkg_postinst() {
	python_mod_optimize /usr/share/${PN}

	if ! use mad; then
		elog ""
		elog "MAD decoding library is disabled."
		elog "This means that playing mp3 will not be possible."
		elog "For mp3 playback, please add the mad USE flag."
	fi

	elog ""
	elog "Installing Quod Libet from an ebuild is not supported"
	elog "upstream. If you encounter any problems, file bugs on"
	elog "bugs.gentoo.org. DO NOT USE THE UPSTREAM BUG SYSTEM."
	elog ""
}

pkg_postrm() {
	python_mod_cleanup /usr/share/${PN}
}
