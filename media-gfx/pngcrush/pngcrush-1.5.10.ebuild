# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pngcrush/pngcrush-1.5.10.ebuild,v 1.1 2002/07/21 18:16:07 blizzy Exp $

S=${WORKDIR}/${P}

DESCRIPTION="PNG optimizing tool"
SRC_URI="mirror://sourceforge/pmt/${P}.tar.gz"
HOMEPAGE="http://pmt.sourceforge.net/pngcrush/"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"

RDEPEND="virtual/glibc"
DEPEND="${RDEPEND}"

src_compile() {
	cp Makefile.gcc Makefile
	emake CFLAGS="-I. ${CFLAGS}" || die
}

src_install () {
	dobin pngcrush
}
