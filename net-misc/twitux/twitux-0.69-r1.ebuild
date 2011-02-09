# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/twitux/twitux-0.69-r1.ebuild,v 1.3 2011/02/09 17:21:11 ssuominen Exp $

EAPI=2
inherit eutils

DESCRIPTION="A Twitter client for the Gnome desktop"
HOMEPAGE="http://live.gnome.org/DanielMorales/Twitux"
SRC_URI="mirror://sourceforge/twitux/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome-keyring nls spell"

RDEPEND="net-libs/libsoup:2.4
	dev-libs/libxml2
	gnome-base/gconf
	x11-libs/libsexy
	x11-libs/libnotify
	>=x11-libs/gtk+-2.14:2
	dev-libs/dbus-glib
	app-text/iso-codes
	media-libs/libcanberra[gtk]
	spell? ( app-text/enchant )
	gnome-keyring? ( gnome-base/gnome-keyring )"
DEPEND="${RDEPEND}
	app-text/rarian
	dev-util/pkgconfig
	app-text/gnome-doc-utils
	nls? ( dev-util/intltool
		sys-devel/gettext )"

# twitux.xml is broken and doesn't validate with xmllint
RESTRICT="test"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-large_avatars.patch \
		"${FILESDIR}"/${P}-libnotify-0.7.patch
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--enable-dbus \
		$(use_enable nls) \
		$(use_enable gnome-keyring) \
		$(use_enable spell)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README TODO
}
