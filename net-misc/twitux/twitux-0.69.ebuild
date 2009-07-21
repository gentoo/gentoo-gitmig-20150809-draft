# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/twitux/twitux-0.69.ebuild,v 1.2 2009/07/21 10:49:12 ssuominen Exp $

EAPI=2

DESCRIPTION="A Twitter client for the Gnome desktop"
HOMEPAGE="http://live.gnome.org/DanielMorales/Twitux"
SRC_URI="mirror://sourceforge/twitux/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="spell gnome-keyring"

RDEPEND="net-libs/libsoup:2.4
	dev-libs/libxml2
	gnome-base/libgnome
	gnome-base/gconf
	>=x11-libs/gtk+-2.14:2
	dev-libs/dbus-glib
	media-libs/libcanberra[gtk]
	spell? ( app-text/aspell )
	gnome-keyring? ( gnome-base/gnome-keyring )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	app-text/gnome-doc-utils"

src_configure() {
	econf \
		$(use_enable spell aspell) \
		$(use_enable gnome-keyring)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS README TODO
}
