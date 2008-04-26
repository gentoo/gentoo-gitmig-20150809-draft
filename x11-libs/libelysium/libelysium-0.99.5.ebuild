# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libelysium/libelysium-0.99.5.ebuild,v 1.6 2008/04/26 07:39:29 drac Exp $

DESCRIPTION="Utility library for applications in the Elysium GNU/Linux distribution."
HOMEPAGE="http://elysium-project.sourceforge.net"
SRC_URI="mirror://sourceforge/elysium-project/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"
IUSE=""

RDEPEND=">=dev-libs/glib-2"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

src_install() {
	einstall || die "install failed"
}
