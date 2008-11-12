# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netspeed_applet/netspeed_applet-0.15.2.ebuild,v 1.1 2008/11/12 11:31:13 leio Exp $

inherit gnome2

DESCRIPTION="Applet showing network traffic for GNOME 2"
HOMEPAGE="http://projects.gnome.org/netspeed/"
SRC_URI="http://www.wh-hms.uni-ulm.de/~mfcn/shared/netspeed/${P}.tar.gz"

SLOT="0"
IUSE=""
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

#FIXME: wireless-tools >= 28pre9 is automagic
RDEPEND=">=gnome-base/gnome-panel-2
	>=gnome-base/libgtop-2.14.2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=app-text/gnome-doc-utils-0.3.2
	>=dev-util/intltool-0.35.0"

DOCS="AUTHORS ChangeLog README"
