# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/music-applet/music-applet-2.0.0.ebuild,v 1.2 2007/01/31 20:01:20 metalgod Exp $

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
	|| ( >=dev-libs/dbus-glib-0.71 <sys-apps/dbus-0.90 )
	dev-lang/python
	>=dev-python/pygtk-2.8"

RDEPEND="dev-util/pkgconfig"

G2CONF="--with-dbus --without-xmms2"
