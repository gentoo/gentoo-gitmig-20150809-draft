# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gqcam/gqcam-0.9.ebuild,v 1.5 2002/10/04 05:55:57 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A V4L-compatible frame grabber - works with many webcams."
SRC_URI="http://cse.unl.edu/~cluening/gqcam/download/${P}.tar.gz"
HOMEPAGE="http://cse.unl.edu/~cluening/gqcam/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="=x11-libs/gtk+-1.2*
		>=media-libs/jpeg-6b-r2
		>=media-libs/libpng-1.2.1-r1"

src_compile() {
	emake || die
}

src_install () {
	dobin gqcam

	dodoc CHANGES COPYING INSTALL README README.threads
}
