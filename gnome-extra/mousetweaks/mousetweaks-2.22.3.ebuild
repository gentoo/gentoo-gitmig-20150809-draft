# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/mousetweaks/mousetweaks-2.22.3.ebuild,v 1.6 2008/09/25 17:15:57 jer Exp $

inherit gnome2

DESCRIPTION="Mouse accessibility enhancements for the GNOME desktop"
HOMEPAGE="http://live.gnome.org/Mousetweaks/Home"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ~ppc64 sparc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.10
	>=gnome-base/gconf-2
	>=gnome-base/libglade-2
	>=gnome-base/gnome-panel-2
	>=dev-libs/dbus-glib-0.72
	gnome-extra/at-spi
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	x11-libs/libXfixes"
DEPEND="${RDEPEND}"
