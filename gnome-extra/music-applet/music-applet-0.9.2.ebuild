# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/music-applet/music-applet-0.9.2.ebuild,v 1.1 2006/07/11 23:59:05 metalgod Exp $

inherit gnome2

DESCRIPTION="GNOME applet to control various music players"
HOMEPAGE="http://web.ics.purdue.edu/~kuliniew/music-applet"
SRC_URI="http://web.ics.purdue.edu/~kuliniew/${PN}/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dbus"

DEPEND=">=x11-libs/gtk+-2.6
	>=gnome-base/libgnomeui-2
	>=gnome-base/gnome-panel-2
	>=sys-apps/dbus-0.60"

RDEPEND="dev-util/pkgconfig"

G2CONF="--with-dbus --without-xmms2"
