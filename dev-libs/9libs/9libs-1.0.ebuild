# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/9libs/9libs-1.0.ebuild,v 1.3 2003/09/08 07:19:26 msterret Exp $

DESCRIPTION="A package of Plan 9 compatability libraries."
HOMEPAGE="http://www.netlib.org/research/9libs/9libs-1.0.README"
SRC_URI="ftp://www.netlib.org/research/9libs/${P}.tar.gz"
LICENSE="PLAN9"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc"
IUSE="X"
DEPEND="virtual/x11"
RDEPEND="${DEPEND}"

src_compile() {
	econf --enable-shared --with-gnu-ld
	make || die
}

src_install() {
	einstall
	dodoc README

}

