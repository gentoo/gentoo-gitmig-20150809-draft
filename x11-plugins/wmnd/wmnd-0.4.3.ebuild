# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmnd/wmnd-0.4.3.ebuild,v 1.9 2004/06/24 23:14:38 agriffis Exp $

DESCRIPTION="WindowMaker Network Devices (dockapp)"
HOMEPAGE="http://www.hydra.ubiest.com/wmnd/"
SRC_URI="http://www.hydra.ubiest.com/wmnd/releases/wmnd-0.4.3.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="x86 sparc amd64"

DEPEND="virtual/x11"

src_compile() {
	econf || die "configure failed"
	emake || die "parallel make failed"
}

src_install() {
	einstall || die "make install failed"
}
