# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmnd/wmnd-0.4.3.ebuild,v 1.1 2002/10/03 15:19:19 raker Exp $

S="${WORKDIR}/${P}"

DESCRIPTION="WindowMaker Network Devices (dockapp)"
HOMEPAGE="http://www.hydra.ubiest.com/wmnd/"
SRC_URI="http://www.hydra.ubiest.com/wmnd/releases/wmnd-0.4.3.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/x11
	media-libs/xpm"

RDEPEND="${DEPEND}"

src_compile() {

	econf || die "configure failed"

	emake || die "parallel make failed"

}

src_install() {

	einstall || die "make install failed"

}
