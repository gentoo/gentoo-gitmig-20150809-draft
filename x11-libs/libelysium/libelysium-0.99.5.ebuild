# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libelysium/libelysium-0.99.5.ebuild,v 1.5 2007/01/14 21:32:04 leio Exp $

DESCRIPTION="Utility library for applications in the Elysium GNU/Linux distribution."
HOMEPAGE="http://elysium-project.sourceforge.net"
SRC_URI="mirror://sourceforge/elysium-project/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"
IUSE=""

DEPEND=">=dev-libs/glib-2
	>=dev-util/pkgconfig-0.9"

src_install() {
	einstall || die "install failed"
}
