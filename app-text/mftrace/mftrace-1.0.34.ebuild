# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mftrace/mftrace-1.0.34.ebuild,v 1.6 2005/08/23 20:33:46 gustavoz Exp $

IUSE="truetype"

DESCRIPTION="traces TeX fonts to PFA or PFB fonts (formerly pktrace)"
HOMEPAGE="http://www.cs.uu.nl/~hanwen/mftrace/"
SRC_URI="http://www.cs.uu.nl/~hanwen/mftrace/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="alpha x86 ppc amd64 sparc ia64"
# SLOT 1 was used in pktrace ebuild
SLOT="1"

DEPEND=">=dev-lang/python-2.2.2"

RDEPEND=">=dev-lang/python-2.2.2
	virtual/tetex
	>=app-text/t1utils-1.25
	|| ( >=media-gfx/autotrace-0.30 media-gfx/potrace )
	truetype? ( || ( media-gfx/fontforge >=media-gfx/pfaedit-030512 ) )"

src_compile() {
	local PYVER=$(python -V 2>&1 | sed -e 's:Python \([0-9].[0-9]\).*:\1:')
	econf --datadir=/usr/lib/python${PYVER}/site-packages || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	local PYVER=$(python -V 2>&1 | sed -e 's:Python \([0-9].[0-9]\).*:\1:')
	make \
		prefix=${D}/usr \
		datadir=${D}/usr/lib/python${PYVER}/site-packages/mftrace \
		mandir=${D}/usr/share/man \
		install || die "make install failed"

	dodoc README.txt ChangeLog
}
