# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gnome-mplayer/gnome-mplayer-0.9.5.ebuild,v 1.1 2009/04/17 21:12:28 yngwin Exp $

EAPI="2"
GCONF_DEBUG=no
inherit gnome2

DESCRIPTION="MPlayer GUI for GNOME Desktop Environment"
HOMEPAGE="http://code.google.com/p/gnome-mplayer"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="+alsa +gnome nautilus ipod +libnotify musicbrainz"

RDEPEND="dev-libs/glib:2
	>=x11-libs/gtk+-2.12:2
	dev-libs/dbus-glib
	media-video/mplayer[ass]
	alsa? ( media-libs/alsa-lib )
	gnome? ( gnome-base/gconf:2
		gnome-base/gvfs )
	nautilus? ( gnome-base/nautilus )
	ipod? ( media-libs/libgpod )
	libnotify? ( x11-libs/libnotify )
	musicbrainz? ( net-misc/curl
		media-libs/musicbrainz:3 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

DOCS="ChangeLog README DOCS/keyboard_shortcuts.txt"

src_configure() {
	G2CONF="${G2CONF}
		--with-gio
		$(use_with alsa)
		$(use_with gnome gconf)
		$(use_enable gnome schemas-install)
		$(use_enable nautilus)
		$(use_with ipod libgpod)
		$(use_with libnotify)
		$(use_with musicbrainz libmusicbrainz3)"
	gnome2_src_configure
}

src_install() {
	gnome2_src_install
	# remove duplicate doc dir
	rm -rf "${D}"/usr/share/doc/${PN}
	# remove empty dir
	rmdir -p "${D}"/var/lib
}
