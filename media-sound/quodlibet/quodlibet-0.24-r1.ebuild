# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/quodlibet/quodlibet-0.24-r1.ebuild,v 1.2 2007/03/29 08:20:25 corsair Exp $

inherit eutils python

DESCRIPTION="Quod Libet is a GTK+-based audio player written in Python."
HOMEPAGE="http://www.sacredchao.net/quodlibet/"
SRC_URI="http://www.sacredchao.net/~piman/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="aac alsa dbus esd flac gnome hal mad mmkeys musepack oss trayicon vorbis"

DEPEND=">=virtual/python-2.4.3-r1
	trayicon? ( >=dev-python/pygtk-2.8 )
	mmkeys? ( >=dev-python/pygtk-2.8 )"

RDEPEND="${DEPEND}
	>=dev-python/pygtk-2.8
	>=media-libs/mutagen-1.6
	>=media-libs/gst-plugins-good-0.10.2
	>=dev-python/gst-python-0.10.2
	hal? ( sys-apps/hal )
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
		>=media-plugins/gst-plugins-gconf-0.10.3
		>=media-plugins/gst-plugins-gnomevfs-0.10.2
		dev-python/feedparser )
	dbus? ( || ( >=dev-python/dbus-python-0.71
	( <sys-apps/dbus-0.90 >=sys-apps/dbus-0.34 ) ) )"

PDEPEND="trayicon? ( media-plugins/quodlibet-trayicon )"

pkg_setup() {
	if use dbus && has_version '<sys-apps/dbus-0.90' && ! built_with_use sys-apps/dbus python ; then
		eerror "dbus is missing python support. Please add 'python'"
		eerror "to your USE flags, and re-emerge sys-apps/dbus"
		die "dbus needs python support"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# multilib fix
	sed -i -e "s,^TODEP = lib/quodlibet,TODEP = \$(libdir)/quodlibet," Makefile

	# no gst-plugins-gconf, attempt to guess the proper pipeline value. Bug #133043, #146728.
	if ! use gnome; then
		local sinktype="alsasink"

		use esd  && sinktype="esdsink"
		use oss  && sinktype="osssink"
		use alsa && sinktype="alsasink"

		elog "Setting the default pipeline to ${sinktype}"

		sed -i -e "s,^          \"pipeline\": \"\",          \"pipeline\": \"${sinktype}\"," config.py
	fi

	epatch "${FILESDIR}/${P}-makefile.patch" || die "epatch failed"
	epatch "${FILESDIR}/${P}-hal.patch"
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
	emake PREFIX=/usr DESTDIR="${D}" libdir="$(get_libdir)" install || die "install failed"
	dodoc README NEWS
}

pkg_postinst() {
	python_mod_optimize /usr/share/${PN}

	if ! use mad; then
		elog ""
		elog "You do not have the 'mad' USE flag enabled."
		elog "gst-plugins-mad, which is required for mp3 playback, may"
		elog "not be installed. For mp3 support, enable the 'mad'"
		elog "USE flag and emerge =media-sound/${P}."
	fi

	if ! use gnome; then
		elog ""
		elog "You do not have the 'gnome' USE flag enabled."
		elog "media-plugins/gst-plugins-gnomevfs may not be installed,"
		elog "so the proper pipeline won't be automatically selected."
		elog "We've tried to select the proper pipeline based on your"
		elog "USE flags, but if we guessed wrong you may have to set"
		elog "'pipeline = ' in your ~/.quodlibet/config file to one"
		elog "of the following: alsasink, osssink, esdsink. To enable"
		elog "automatic selection of the proper pipeline, enable the"
		elog "'gnome' USE flag and emerge =media-sound/${P}."
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
