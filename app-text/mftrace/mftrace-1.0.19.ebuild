# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mftrace/mftrace-1.0.19.ebuild,v 1.5 2004/03/21 15:14:26 dholm Exp $

IUSE="truetype"

PYVER=$(python -V 2>&1 | sed -e 's:Python \([0-9].[0-9]\).*:\1:')
DESCRIPTION="traces TeX fonts to PFA or PFB fonts (formerly pktrace)"
HOMEPAGE="http://www.cs.uu.nl/~hanwen/mftrace/"
SRC_URI="http://www.cs.uu.nl/~hanwen/mftrace/${P}.tar.gz"
LICENSE="GPL-1"
KEYWORDS="alpha x86 ~ppc"
# SLOT 1 was used in pktrace ebuild
SLOT="1"

DEPEND=">=dev-lang/python-2.2.1-r2"

RDEPEND=">=dev-lang/python-2.2.2
	>=app-text/tetex-1.0.7-r12
	>=app-text/t1utils-1.25
	>=media-gfx/autotrace-0.30
	truetype? ( >=media-gfx/pfaedit-030512 )"

src_compile() {
	econf --datadir=/usr/lib/python${PYVER}/site-packages
	emake || die "emake failed"
}

src_install () {
	make \
		prefix=${D}/usr \
		datadir=${D}/usr/lib/python${PYVER}/site-packages/mftrace \
		mandir=${D}/usr/share/man \
		install || die "make install failed"

	dodoc README.txt ChangeLog
}
