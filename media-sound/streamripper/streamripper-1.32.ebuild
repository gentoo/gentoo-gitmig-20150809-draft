# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/streamripper/streamripper-1.32.ebuild,v 1.1 2002/07/23 18:39:19 aliz Exp $

DESCRIPTION="Extracts and records individual MP3 file tracks from shoutcast streams"
HOMEPAGE="http://streamripper.sourceforge.net"
SRC_URI="http://streamripper.sourceforge.net/dl/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
DEPEND="virtual/glibc"
S=${WORKDIR}/${P}
RDEPEND=$DEPEND

src_compile() {
	./configure \
		--host=${CHOST} || die "./configure failed"
	emake || die
}

src_install () {
	dobin streamripper
	dodoc CHANGES COPYING README THANKS TODO 
}

