# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /home/cvsroot/gentoo-x86/x11-terms/aterm/,v 1.2 2001/02/15 18:17:31 achim Exp
# $Header: /var/cvsroot/gentoo-x86/x11-terms/root-tail/root-tail-0.0.10.ebuild,v 1.7 2002/07/17 00:41:10 seemant Exp $


S=${WORKDIR}/${P}
DESCRIPTION="Terminal to display (multiple) log files on the root window"
SRC_URI="http://www.goof.com/pcg/marc/data/${P}.tar.gz"
HOMEPAGE="http://www.var.cx/root-tail/"
SLOT="0"
KEYWORDS="x86"
LICENSE="GPL"

DEPEND="virtual/x11"

src_compile() {
	xmkmf -a || die
	make || die
}

src_install() {
	make DESTDIR=${D} install install.man || die
}
