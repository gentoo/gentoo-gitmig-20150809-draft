# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/root-tail/root-tail-1.1.ebuild,v 1.3 2004/06/19 13:38:05 pyrania Exp $

DESCRIPTION="Terminal to display (multiple) log files on the root window"
HOMEPAGE="http://www.goof.com/pcg/marc/root-tail.html"
SRC_URI="http://www.goof.com/pcg/marc/data/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~amd64 ~ppc"
IUSE=""

DEPEND="virtual/x11"

src_compile() {
	xmkmf -a
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install install.man || die "make install failed"
	dodoc Changes README
}
