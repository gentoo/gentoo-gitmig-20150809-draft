# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmnd/wmnd-0.4.5.ebuild,v 1.1 2003/06/05 00:46:20 robh Exp $

S="${WORKDIR}/${P}"

DESCRIPTION="WindowMaker Network Devices (dockapp)"
HOMEPAGE="http://www.yuv.info/wmnd/"
SRC_URI="http://www.yuv.info/wmnd/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc "

DEPEND="virtual/x11
	x11-wm/windowmaker"


src_compile() {

	econf || die "configure failed"

	emake || die "parallel make failed"

}

src_install() {

	einstall || die "make install failed"

}
