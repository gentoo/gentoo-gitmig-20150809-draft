# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gnome-mplayer/gnome-mplayer-1.0.3.ebuild,v 1.1 2011/04/22 11:13:05 ssuominen Exp $

EAPI=3
GCONF_DEBUG=no
inherit eutils gnome2

DESCRIPTION="A GTK+ interface to MPlayer"
HOMEPAGE="http://code.google.com/p/gnome-mplayer/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="alsa dbus gnome ipod libnotify musicbrainz pulseaudio"

RDEPEND=">=dev-libs/glib-2.26:2
	>=media-video/mplayer-1.0_rc4_p20091026[ass]
	>=x11-libs/gtk+-2.22:2
	x11-libs/libX11
	x11-libs/libXScrnSaver
	alsa? ( media-libs/alsa-lib )
	dbus? ( >=dev-libs/dbus-glib-0.88 )
	gnome? ( gnome-base/gconf:2
		gnome-base/gvfs
		gnome-base/nautilus )
	ipod? ( >=media-libs/libgpod-0.7 )
	libnotify? ( x11-libs/libnotify )
	musicbrainz? ( net-misc/curl
		>=media-libs/musicbrainz-3 )
	pulseaudio? ( >=media-sound/pulseaudio-0.9.14 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	G2CONF="--disable-dependency-tracking
		$(use_enable gnome schemas-install)
		$(use_enable gnome nautilus)
		--enable-panscan
		--disable-gseal
		--with-gio
		$(use_with dbus)
		$(use_with gnome gconf)
		$(use_with alsa)
		$(use_with pulseaudio)
		$(use_with libnotify)
		$(use_with ipod libgpod)
		$(use_with musicbrainz libmusicbrainz3)
		--without-gpm-new-method
		--without-gpm-old-method"

	DOCS="ChangeLog README DOCS/*.txt DOCS/tech/*"
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.0.2-implicit_declaration.patch
	gnome2_src_prepare
}

src_install() {
	gnome2_src_install
	rm -rf "${D}"/usr/share/doc/${PN}
	rmdir -p "${D}"/var/lib
}
