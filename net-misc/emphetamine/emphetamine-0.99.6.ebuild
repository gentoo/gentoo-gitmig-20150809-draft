# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/emphetamine/emphetamine-0.99.6.ebuild,v 1.8 2010/04/08 21:01:46 ssuominen Exp $

GCONF_DEBUG=no

inherit gnome2

DESCRIPTION="GNOME-based download manager."
HOMEPAGE="http://emphetamine.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND="x11-libs/libelysium
	x11-libs/libelysiumui"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog README"
