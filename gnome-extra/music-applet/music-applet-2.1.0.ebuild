# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/music-applet/music-applet-2.1.0.ebuild,v 1.3 2007/07/12 04:19:34 mr_bones_ Exp $

inherit gnome2

DESCRIPTION="GNOME applet to control various music players"
HOMEPAGE="http://www.kuliniewicz.org/music-applet/"
SRC_URI="http://www.kuliniewicz.org/${PN}/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.6
	>=gnome-base/libgnomeui-2
	>=gnome-base/gnome-panel-2
	>=dev-python/gnome-python-desktop-2.14
	>=dev-python/numeric-24.2
	>=dev-python/dbus-python-0.80
	>=dev-libs/dbus-glib-0.71
	>=dev-python/pygtk-2.6"

RDEPEND="dev-util/pkgconfig
	dev-util/intltool"
