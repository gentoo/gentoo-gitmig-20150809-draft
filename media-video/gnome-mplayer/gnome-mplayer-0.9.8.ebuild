# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gnome-mplayer/gnome-mplayer-0.9.8.ebuild,v 1.7 2009/12/11 19:55:23 ranger Exp $

EAPI=2
GCONF_DEBUG=no
inherit gnome2

DESCRIPTION="MPlayer GUI for GNOME Desktop Environment"
HOMEPAGE="http://code.google.com/p/gnome-mplayer"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc64 x86 ~x86-fbsd"
IUSE="alsa gnome ipod libnotify musicbrainz pulseaudio"

RDEPEND=">=dev-libs/glib-2.14:2
	>=x11-libs/gtk+-2.12:2
	>=dev-libs/dbus-glib-0.70
	media-video/mplayer[ass]
	alsa? ( media-libs/alsa-lib )
	gnome? ( gnome-base/gconf:2
		gnome-base/gvfs
		gnome-base/nautilus )
	ipod? ( >=media-libs/libgpod-0.7 )
	libnotify? ( x11-libs/libnotify )
	musicbrainz? ( net-misc/curl
		media-libs/musicbrainz:3 )
	pulseaudio? ( >=media-sound/pulseaudio-0.9.14 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	DOCS="ChangeLog README DOCS/keyboard_shortcuts.txt"
	G2CONF="--disable-dependency-tracking
		$(use_enable gnome schemas-install)
		$(use_enable gnome nautilus)
		--with-gio
		$(use_with gnome gconf)
		$(use_with alsa)
		$(use_with libnotify)
		$(use_with ipod libgpod)
		$(use_with musicbrainz libmusicbrainz3)
		$(use_with pulseaudio flat-volume)
		--without-gpm-new-method
		--without-gpm-old-method"
}

src_install() {
	gnome2_src_install
	rm -rf "${D}"/usr/share/doc/${PN}
	rmdir -p "${D}"/var/lib # rm empty dir from destdir
}
