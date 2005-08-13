# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netspeed_applet/netspeed_applet-0.12.1.ebuild,v 1.4 2005/08/13 23:30:12 hansmi Exp $

inherit gnome2

DESCRIPTION="Applet showing network traffic for GNOME 2"
HOMEPAGE="http://mfcn.ilo.de/netspeed_applet/"
SRC_URI="http://www.wh-hms.uni-ulm.de/~mfcn/shared/netspeed/${P}.tar.gz"

SLOT="0"
IUSE="gnome"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc sparc x86"

RDEPEND=">=gnome-base/libgnomeui-2
	>=gnome-base/gnome-panel-2
	gnome? ( >=gnome-base/libgtop-2.5 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29"

G2CONF="${G2CONF} `use_enable gnome libgtop`"

DOCS="README NEWS ChangeLog COPYING AUTHORS INSTALL"
