# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/music-applet/music-applet-0.9.2.ebuild,v 1.4 2007/04/07 18:57:14 genstef Exp $

inherit gnome2

DESCRIPTION="GNOME applet to control various music players"
HOMEPAGE="http://www.kuliniewicz.org/music-applet/"
SRC_URI="http://www.kuliniewicz.org/${PN}/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dbus"

DEPEND=">=x11-libs/gtk+-2.6
	>=gnome-base/libgnomeui-2
	>=gnome-base/gnome-panel-2
	>=dev-python/dbus-python-0.80
	>=dev-libs/dbus-glib-0.71"

RDEPEND="dev-util/pkgconfig"

G2CONF="--with-dbus --without-xmms2"
