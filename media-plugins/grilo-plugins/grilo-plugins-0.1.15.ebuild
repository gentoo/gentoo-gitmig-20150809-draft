# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/grilo-plugins/grilo-plugins-0.1.15.ebuild,v 1.2 2011/06/15 16:43:45 pacho Exp $

EAPI="4"
GNOME2_LA_PUNT="yes"
GNOME_TARBALL_SUFFIX="bz2"

inherit gnome2

DESCRIPTION="A framework for easy media discovery and browsing"
HOMEPAGE="https://live.gnome.org/Grilo"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+youtube +vimeo upnp"

RDEPEND="
	>=dev-libs/glib-2.26:2
	=media-libs/grilo-${PV}[network]

	dev-libs/libxml2:2
	dev-db/sqlite:3

	youtube? ( >=dev-libs/libgdata-0.4.0 )
	upnp? ( >=net-libs/gupnp-0.13
		>=net-libs/gupnp-av-0.5 )
	vimeo? ( net-libs/libsoup:2.4
		dev-libs/libgcrypt )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

# `make check` doesn't do anything, and ${S}/test/test fails without all plugins
RESTRICT="test"

pkg_setup() {
	DOCS="AUTHORS NEWS README"
	# --enable-debug only changes CFLAGS, useless for us
	G2CONF="${G2CONF}
		--disable-maintainer-mode
		--disable-static
		--disable-debug
		--disable-uninstalled"

	# Plugins
	# TODO: Enable tracker support
	G2CONF="${G2CONF}
		--enable-filesystem
		--enable-jamendo
		--enable-lastfm-albumart
		--enable-flickr
		--enable-podcasts
		--enable-bookmarks
		--disable-shoutcast
		--enable-apple-trailers
		--enable-metadata-store
		--enable-gravatar
		--disable-tracker
		--enable-localmetadata
		$(use_enable upnp)
		$(use_enable youtube)
		$(use_enable vimeo)"
}

src_prepare() {
	sed -i -e 's/^\(SUBDIRS .*\)test/\1/g' Makefile.*
	gnome2_src_prepare
}
