# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netspeed_applet/netspeed_applet-0.9.ebuild,v 1.1 2003/06/29 14:51:42 foser Exp $

inherit gnome2

IUSE=""
DESCRIPTION="Applet showing network traffic for GNOME 2"
HOMEPAGE="http://mfcn.ilo.de/netspeed_applet/"
SRC_URI="http://mfcn.ilo.de/netspeed_applet/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"

RDEPEND=">=gnome-base/libgnomeui-2
	>=gnome-base/libgtop-2
	>=gnome-base/gnome-panel-2"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.21"

DOCS="README NEWS ChangeLog COPYING AUTHORS INSTALL"
