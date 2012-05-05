# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gnome-mplayer/gnome-mplayer-1.0.6.ebuild,v 1.2 2012/05/05 08:58:55 jdhore Exp $

EAPI=4
inherit fdo-mime gnome2-utils

DESCRIPTION="A GTK+ interface to MPlayer"
HOMEPAGE="http://code.google.com/p/gnome-mplayer/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="alsa +dbus +dconf gnome ipod libnotify musicbrainz pulseaudio"

COMMON_DEPEND=">=dev-libs/glib-2.26
	>=media-libs/gmtk-${PV}[dconf=]
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXScrnSaver
	alsa? ( media-libs/alsa-lib )
	dbus? ( >=dev-libs/dbus-glib-0.92 )
	gnome? ( gnome-base/nautilus )
	ipod? ( >=media-libs/libgpod-0.7 )
	libnotify? ( >=x11-libs/libnotify-0.7 )
	musicbrainz? (
		media-libs/musicbrainz:3
		net-misc/curl
		)
	pulseaudio? ( >=media-sound/pulseaudio-0.9.14 )"
RDEPEND="${COMMON_DEPEND}
	|| ( >=media-video/mplayer-1.0_rc4_p20100101[ass] media-video/mplayer2[ass] )"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	sys-devel/gettext"

DOCS="ChangeLog README DOCS/*.txt DOCS/tech/*.txt"

src_configure() {
	econf \
		--enable-gtk3 \
		$(use_enable gnome nautilus) \
		--with-gio \
		$(use_with dbus) \
		$(use_with alsa) \
		$(use_with pulseaudio) \
		$(use_with libnotify) \
		$(use_with ipod libgpod) \
		$(use_with musicbrainz libmusicbrainz3)
}

src_install() {
	default
	rm -rf "${ED}"usr/share/doc/${PN}
}

pkg_preinst() {
	gnome2_icon_savelist
	gnome2_schemas_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
	gnome2_schemas_update
}
