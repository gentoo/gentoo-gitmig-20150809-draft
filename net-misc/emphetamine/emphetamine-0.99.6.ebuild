# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/emphetamine/emphetamine-0.99.6.ebuild,v 1.7 2008/04/26 13:18:11 drac Exp $

GCONF_DEBUG=no

inherit gnome2

DESCRIPTION="GNOME-based download manager."
HOMEPAGE="http://emphetamine.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="x11-libs/libelysium
	x11-libs/libelysiumui"

DOCS="AUTHORS ChangeLog README"
