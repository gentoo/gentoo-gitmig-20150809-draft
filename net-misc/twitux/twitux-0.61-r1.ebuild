# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/twitux/twitux-0.61-r1.ebuild,v 1.2 2008/05/20 16:28:27 gregkh Exp $

EAPI=1

DESCRIPTION="A Twitter client for the Gnome desktop"
HOMEPAGE="http://live.gnome.org/DanielMorales/Twitux"
SRC_URI="mirror://sourceforge/twitux/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="spell gnome-keyring"

DEPEND="net-libs/libsoup:2.4
	dev-libs/libxml2
	gnome-base/libglade
	gnome-base/libgnome
	gnome-base/gconf
	x11-libs/gtk+:2
	dev-libs/dbus-glib
	spell? ( app-text/aspell )
	gnome-keyring? ( gnome-base/gnome-keyring )"
RDEPEND="${DEPEND}"

src_compile() {
	econf $(use_enable spell aspell) \
		$(use_enable gnome-keyring) || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS README TODO
}
