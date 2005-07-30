# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/whatmask/whatmask-1.1.ebuild,v 1.14 2005/07/30 18:41:26 swegener Exp $

IUSE=""
DESCRIPTION="little C program to compute different subnet mask notations"
HOMEPAGE="http://www.laffeycomputer.com/whatmask.html"
SRC_URI="http://downloads.laffeycomputer.com/current_builds/whatmask/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"

DEPEND="virtual/libc"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README INSTALL AUTHORS ChangeLog NEWS
}
