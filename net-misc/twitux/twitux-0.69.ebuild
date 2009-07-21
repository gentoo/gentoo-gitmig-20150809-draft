# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/twitux/twitux-0.69.ebuild,v 1.4 2009/07/21 11:10:32 ssuominen Exp $

EAPI=2

DESCRIPTION="A Twitter client for the Gnome desktop"
HOMEPAGE="http://live.gnome.org/DanielMorales/Twitux"
SRC_URI="mirror://sourceforge/twitux/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dbus gnome-keyring nls spell"

RDEPEND="net-libs/libsoup:2.4
	dev-libs/libxml2
	gnome-base/gconf
	>=x11-libs/gtk+-2.14:2
	dbus? ( dev-libs/dbus-glib )
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

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable nls) \
		$(use_enable dbus) \
		$(use_enable gnome-keyring) \
		$(use_enable spell)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS README TODO
}
