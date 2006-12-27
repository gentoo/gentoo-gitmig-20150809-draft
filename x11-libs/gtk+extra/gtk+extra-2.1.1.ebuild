# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk+extra/gtk+extra-2.1.1.ebuild,v 1.6 2006/12/27 13:46:18 gustavoz Exp $

inherit gnome2

DESCRIPTION="Useful Additional GTK+ widgets"
HOMEPAGE="http://gtkextra.sourceforge.net"
SRC_URI="mirror://sourceforge/scigraphica/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ppc ~ppc64 sparc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.0
		>=dev-libs/glib-2.0"
DEPEND="${RDEPEND}
		dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog INSTALL README"
