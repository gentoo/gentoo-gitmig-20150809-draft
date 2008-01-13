# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mftrace/mftrace-1.0.34.ebuild,v 1.9 2008/01/13 13:33:36 aballier Exp $

IUSE="truetype"

DESCRIPTION="traces TeX fonts to PFA or PFB fonts (formerly pktrace)"
HOMEPAGE="http://www.xs4all.nl/~hanwen/mftrace/"
SRC_URI="http://www.xs4all.nl/~hanwen/mftrace/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="alpha x86 ppc amd64 sparc ia64"
# SLOT 1 was used in pktrace ebuild
SLOT="1"

DEPEND=">=dev-lang/python-2.2.2
	|| ( >=media-gfx/autotrace-0.30 media-gfx/potrace )"

RDEPEND=">=dev-lang/python-2.2.2
	virtual/tetex
	>=app-text/t1utils-1.25
	truetype? ( media-gfx/fontforge )"

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
