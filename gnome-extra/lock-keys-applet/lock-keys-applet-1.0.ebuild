# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/lock-keys-applet/lock-keys-applet-1.0.ebuild,v 1.1 2003/05/06 17:52:44 foser Exp $

inherit gnome2

DESCRIPTION="An applet that shows the status of your Caps, Num and Scroll Lock keys"
HOMEPAGE="http://mfcn.ilo.de/led_applet/"
SRC_URI="http://mfcn.ilo.de/led_applet/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=gnome-base/libgnomeui-2
	>=gnome-base/gnome-panel-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.21
	app-text/scrollkeeper"

DOCS="ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS README TODO"

