# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmnd/wmnd-0.4.3.ebuild,v 1.8 2004/06/22 21:14:40 s4t4n Exp $

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
