# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gqcam/gqcam-0.9.ebuild,v 1.12 2004/07/14 21:37:43 agriffis Exp $

DESCRIPTION="A V4L-compatible frame grabber - works with many webcams."
SRC_URI="http://cse.unl.edu/~cluening/gqcam/download/${P}.tar.gz"
HOMEPAGE="http://cse.unl.edu/~cluening/gqcam/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~mips amd64 ~ppc"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
		>=media-libs/jpeg-6b-r2
		>=media-libs/libpng-1.2.1-r1"

src_unpack() {
	unpack ${A}

	cd ${S}
	mv Makefile Makefile.bad
	sed -e "s:-lpng:\`libpng-config --libs\`:" Makefile.bad > Makefile
}

src_compile() {
	emake || die
}

src_install () {
	dobin gqcam

	dodoc CHANGES COPYING INSTALL README README.threads
}
