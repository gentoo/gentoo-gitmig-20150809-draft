# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/root-tail/root-tail-0.0.10.ebuild,v 1.9 2002/10/17 15:33:58 aliz Exp $


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
