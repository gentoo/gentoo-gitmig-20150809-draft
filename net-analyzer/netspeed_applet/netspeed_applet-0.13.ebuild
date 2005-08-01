# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netspeed_applet/netspeed_applet-0.13.ebuild,v 1.1 2005/08/01 12:03:41 foser Exp $

inherit gnome2

DESCRIPTION="Applet showing network traffic for GNOME 2"
HOMEPAGE="http://mfcn.ilo.de/netspeed_applet/"
SRC_URI="http://www.wh-hms.uni-ulm.de/~mfcn/shared/netspeed/${P}.tar.gz"

SLOT="0"
IUSE=""
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"

RDEPEND=">=gnome-base/libgnomeui-2.8
	>=gnome-base/gnome-panel-2
	>=gnome-base/libgtop-2.10"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29"

DOCS="README NEWS ChangeLog COPYING AUTHORS INSTALL"
