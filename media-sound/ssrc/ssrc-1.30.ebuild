# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ssrc/ssrc-1.30.ebuild,v 1.2 2007/07/11 19:30:24 mr_bones_ Exp $

inherit eutils

DESCRIPTION="A fast and high quality sampling rate converter"
HOMEPAGE="http://shibatch.sourceforge.net"
SRC_URI="http://shibatch.sf.net/download/${P}.tgz"
LICENSE="LGPL-2.1"
SLOT="0"

#-sparc: kde's pop.wav "Error: Only PCM is supported."

KEYWORDS="~x86 ~amd64 -sparc"
IUSE=""

RDEPEND="virtual/libc"
DEPEND="app-arch/unzip"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-makefile.patch"
}

src_compile() {
	# Local CFLAGS should overwrite the ones in the Makefile
	emake -e || die
}

src_install() {
	dobin ssrc
	dobin ssrc_hp
	dodoc ssrc.txt history.txt
}
