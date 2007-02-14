# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/whatmask/whatmask-1.2.ebuild,v 1.10 2007/02/14 22:17:11 dang Exp $

IUSE=""
DESCRIPTION="little C program to compute different subnet mask notations"
HOMEPAGE="http://www.laffeycomputer.com/whatmask.html"
SRC_URI="http://downloads.laffeycomputer.com/current_builds/whatmask/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc sparc ~x86"

DEPEND="virtual/libc"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README INSTALL AUTHORS ChangeLog NEWS
}
