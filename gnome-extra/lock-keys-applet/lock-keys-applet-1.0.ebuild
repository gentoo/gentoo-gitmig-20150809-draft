# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/lock-keys-applet/lock-keys-applet-1.0.ebuild,v 1.10 2007/11/21 11:41:12 drac Exp $

inherit gnome2

DESCRIPTION="An applet that shows the status of your Caps, Num and Scroll Lock keys"
HOMEPAGE="http://mfcn.ilo.de/led_applet"
SRC_URI="http://mfcn.ilo.de/led_applet/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

RDEPEND=">=gnome-base/libgnomeui-2
	>=gnome-base/gnome-panel-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.21
	app-text/scrollkeeper"

DOCS="AUTHORS ChangeLog NEWS README TODO"
