# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mftrace/mftrace-1.2.9.ebuild,v 1.3 2007/10/05 10:11:17 armin76 Exp $

IUSE="truetype"
inherit python multilib

DESCRIPTION="traces TeX fonts to PFA or PFB fonts (formerly pktrace)"
HOMEPAGE="http://lilypond.org/download/sources/mftrace/"
SRC_URI="http://lilypond.org/download/sources/mftrace/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="alpha ~amd64 ~ia64 ~ppc ~sparc x86"
# SLOT 1 was used in pktrace ebuild
SLOT="1"

DEPEND=">=dev-lang/python-2.2.2"

RDEPEND="${DEPEND}
	virtual/tetex
	>=app-text/t1utils-1.25
	|| ( media-gfx/potrace >=media-gfx/autotrace-0.30 )
	truetype? ( media-gfx/fontforge )"

src_compile() {
	python_version
	econf --datadir=/usr/$(get_libdir)/python${PYVER}/site-packages || \
	die "econf failed"
	emake CFLAGS="-Wall ${CFLAGS}" || die "emake failed"
}

src_install () {
	python_version
	make \
		prefix=${D}/usr \
		datadir=${D}/usr/$(get_libdir)/python${PYVER}/site-packages/mftrace \
		mandir=${D}/usr/share/man \
		install || die "make install failed"

	dodoc README.txt ChangeLog
}
