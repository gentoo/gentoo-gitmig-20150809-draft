# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/9libs/9libs-1.0.ebuild,v 1.6 2004/06/01 20:58:08 mr_bones_ Exp $

DESCRIPTION="A package of Plan 9 compatability libraries."
HOMEPAGE="http://www.netlib.org/research/9libs/9libs-1.0.README"
SRC_URI="ftp://www.netlib.org/research/9libs/${P}.tar.gz"

LICENSE="PLAN9"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc"
IUSE=""

DEPEND="virtual/x11"

src_compile() {
	econf --enable-shared --with-gnu-ld || die "econf failed"
	make || die
}

src_install() {
	einstall
	dodoc README

}

