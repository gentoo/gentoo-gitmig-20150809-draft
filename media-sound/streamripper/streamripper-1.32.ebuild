# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/streamripper/streamripper-1.32.ebuild,v 1.3 2003/03/25 06:46:29 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Extracts and records individual MP3 file tracks from shoutcast streams"
HOMEPAGE="http://streamripper.sourceforge.net"
SRC_URI="${HOMEPAGE}/files/${P}.tar.gz"


SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

DEPEND="virtual/glibc"


src_compile() {
	./configure \
		--host=${CHOST} || die "./configure failed"
	emake || die
}

src_install () {
	dobin streamripper
	dodoc CHANGES COPYING README THANKS TODO 
}

