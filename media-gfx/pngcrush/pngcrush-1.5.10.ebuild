# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pngcrush/pngcrush-1.5.10.ebuild,v 1.11 2004/07/01 10:50:00 eradicator Exp $

IUSE=""

S=${WORKDIR}/${P}

DESCRIPTION="PNG optimizing tool"
SRC_URI="mirror://sourceforge/pmt/${P}.tar.gz"
HOMEPAGE="http://pmt.sourceforge.net/pngcrush/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc amd64"

DEPEND="virtual/libc"

src_compile() {
	cp Makefile.gcc Makefile
	emake CFLAGS="-I. ${CFLAGS}" || die
}

src_install() {
	dobin pngcrush
}
