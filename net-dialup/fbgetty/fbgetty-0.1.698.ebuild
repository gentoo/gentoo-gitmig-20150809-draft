# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/fbgetty/fbgetty-0.1.698.ebuild,v 1.8 2004/12/19 19:13:32 dholm Exp $

DESCRIPTION="An extended getty for the framebuffer console"
HOMEPAGE="http://projects.meuh.org/fbgetty/"
SRC_URI="${HOMEPAGE}downloads/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"
IUSE=""
DEPEND="virtual/libc"

src_install() {
	einstall || die "make install failed"
}
