# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libelysium/libelysium-0.99.9.ebuild,v 1.3 2005/05/10 09:37:52 dholm Exp $

DESCRIPTION="Utility library for applications in the Elysium GNU/Linux distribution."
HOMEPAGE="http://elysium-project.sourceforge.net"
SRC_URI="mirror://sourceforge/elysium-project/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
SLOT="0"
IUSE=""

DEPEND=">=dev-libs/glib-2"

src_install() {
	einstall || die "install failed"
}
