# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-trayicon/synce-trayicon-0.13.ebuild,v 1.1 2009/01/21 00:44:52 mescalinum Exp $

inherit eutils gnome2

DESCRIPTION="SynCE - Gnome trayicon"
HOMEPAGE="http://sourceforge.net/projects/synce/"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="sys-apps/dbus
		dev-libs/dbus-glib
		>=dev-libs/glib-2.0
		>=x11-libs/gtk+-2.0
		gnome-base/libgnome
		gnome-base/libgnomeui
		gnome-base/libgtop
		gnome-base/libglade
		gnome-base/gnome-keyring
		gnome-base/gnome-common
		~app-pda/synce-libsynce-${PV}
		~app-pda/synce-librra-${PV}
		~app-pda/synce-librapi2-${PV}
		>=app-pda/orange-0.3.2"
RDEPEND="${DEPEND}"

SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

src_install() {
	emake DESTDIR="${D}" install || die
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
