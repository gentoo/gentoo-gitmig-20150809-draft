# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-trayicon/synce-trayicon-0.13.ebuild,v 1.5 2009/05/10 18:28:51 mescalinum Exp $

inherit eutils gnome2 versionator

DESCRIPTION="SynCE - Gnome trayicon"
HOMEPAGE="http://sourceforge.net/projects/synce/"
LICENSE="MIT"

synce_PV=$(get_version_component_range 1-2)

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RDEPEND="sys-apps/dbus
		dev-libs/dbus-glib
		>=dev-libs/glib-2.0
		>=x11-libs/gtk+-2.0
		gnome-base/libgnome
		gnome-base/libgnomeui
		gnome-base/libgtop
		gnome-base/libglade
		>=gnome-base/gnome-keyring-2.20.3
		=app-pda/synce-libsynce-${synce_PV}*
		=app-pda/synce-librra-${synce_PV}*
		=app-pda/synce-librapi2-${synce_PV}*
		>=app-pda/orange-0.3.2"
DEPEND="${DEPEND}
		gnome-base/gnome-common"

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
