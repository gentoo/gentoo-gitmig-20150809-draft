# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mftrace/mftrace-1.0.33.ebuild,v 1.3 2004/07/19 09:43:38 eradicator Exp $

IUSE="truetype"

PYVER=$(python -V 2>&1 | sed -e 's:Python \([0-9].[0-9]\).*:\1:')
DESCRIPTION="traces TeX fonts to PFA or PFB fonts (formerly pktrace)"
HOMEPAGE="http://www.cs.uu.nl/~hanwen/mftrace/"
SRC_URI="http://www.cs.uu.nl/~hanwen/mftrace/${P}.tar.gz"
LICENSE="GPL-1"
KEYWORDS="~alpha ~x86 ~ppc ~amd64 ~sparc"
# SLOT 1 was used in pktrace ebuild
SLOT="1"

DEPEND=">=dev-lang/python-2.2.1-r2"

RDEPEND=">=dev-lang/python-2.2.2
	virtual/tetex
	>=app-text/t1utils-1.25
	>=media-gfx/autotrace-0.30
	truetype? ( || ( media-gfx/fontforge >=media-gfx/pfaedit-030512 ) )"

src_compile() {
	econf --datadir=/usr/lib/python${PYVER}/site-packages || die "econf failed"
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
