# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/xnoise/xnoise-0.1.30.ebuild,v 1.2 2012/05/05 08:55:51 mgorny Exp $

EAPI=4
inherit fdo-mime gnome2-utils

DESCRIPTION="A media player for Gtk+ with a slick GUI, great speed and lots of
features"
HOMEPAGE="http://www.xnoise-media-player.com/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+lastfm libnotify +lyrics"

RDEPEND="dev-db/sqlite:3
	>=dev-libs/glib-2.26:2
	dev-libs/libunique:1
	dev-libs/libxml2:2
	media-libs/gst-plugins-base:0.10
	media-libs/gstreamer:0.10
	media-libs/taglib
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:2
	lastfm? ( net-libs/libsoup:2.4 )
	libnotify? ( x11-libs/libnotify )
	lyrics? ( net-libs/libsoup:2.4 )"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
	sys-devel/gettext"

DOCS=( AUTHORS README )

src_configure() {
	econf \
		--disable-soundmenu \
		--enable-soundmenu2 \
		$(use_enable lastfm) \
		$(use_enable libnotify notifications) \
		$(use_enable lyrics leoslyrics) \
		$(use_enable lyrics lyricsfly) \
		$(use_enable lyrics lyricwiki) \
		$(use_enable lyrics chartlyrics)
}

src_install() {
	default
	find "${ED}" -type f -name "*.la" -delete || die
	rm -rf "${ED}"/usr/share/${PN}/license || die
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
