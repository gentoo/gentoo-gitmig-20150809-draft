# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ssrc/ssrc-1.29.ebuild,v 1.6 2004/07/19 22:37:04 eradicator Exp $

inherit flag-o-matic

S=${WORKDIR}
DESCRIPTION="A fast and high quality sampling rate converter"
HOMEPAGE="http://shibatch.sourceforge.net"
SRC_URI="http://shibatch.sf.net/download/${P}.zip"
LICENSE="LGPL-2.1"
SLOT="0"

#-amd64: 1.29: segfault on 44100 -> 11025 kde's pop.wav
#-sparc: same test as amd64... "Error: Only PCM is supported."

KEYWORDS="x86 -amd64 -sparc"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	append-flags -lm
	# Local CFLAGS should overwrite the ones in the Makefile
	emake -e || die
}

src_install() {
	dobin ssrc
	dobin ssrc_hp
	dodoc ssrc.txt history.txt
}
