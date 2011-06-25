# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/xnoise/xnoise-0.1.25.ebuild,v 1.1 2011/06/25 16:35:19 angelos Exp $

EAPI=4
inherit autotools eutils fdo-mime gnome2-utils

DESCRIPTION="A media player for Gtk+ with a slick GUI, great speed and lots of
features"
HOMEPAGE="http://www.xnoise-media-player.com/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+cover libnotify +lyrics"

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
	cover? ( net-libs/libsoup:2.4 )
	libnotify? ( x11-libs/libnotify )
	lyrics? ( net-libs/libsoup:2.4 )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

DOCS=( AUTHORS NEWS README )

src_prepare() {
	epatch "${FILESDIR}"/${P}-automagic-libindicate.patch
	eautoreconf
}

src_configure() {
	econf \
		--disable-soundmenu \
		--enable-soundmenu2 \
		$(use_enable cover lastfm-covers) \
		$(use_enable libnotify notifications) \
		$(use_enable lyrics leoslyrics) \
		$(use_enable lyrics lyricsfly) \
		$(use_enable lyrics lyricwiki) \
		$(use_enable lyrics chartlyrics)
}

src_install() {
	default
	find "${ED}" -type f -name "*.la" -exec rm -rf {} + || die
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
