# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pngcrush/pngcrush-1.5.10.ebuild,v 1.3 2002/09/10 17:00:51 cybersystem Exp $

S=${WORKDIR}/${P}

DESCRIPTION="PNG optimizing tool"
SRC_URI="mirror://sourceforge/pmt/${P}.tar.gz"
HOMEPAGE="http://pmt.sourceforge.net/pngcrush/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc"

DEPEND="virtual/glibc"

src_compile() {
	cp Makefile.gcc Makefile
	emake CFLAGS="-I. ${CFLAGS}" || die
}

src_install () {
	dobin pngcrush
}
