# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3gain/mp3gain-1.4.3.ebuild,v 1.1 2004/01/14 00:10:22 mholzer Exp $ 

S=${WORKDIR}
DESCRIPTION="MP3Gain automatically adjusts mp3s so that they all have the same volume"
HOMEPAGE="http://mp3gain.sourceforge.net"
MY_P=${P//./_}
SRC_URI="mirror://sourceforge/${PN}/${MY_P}-src.zip"
RESTRICT="nomirror"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~hppa"

src_compile() {
	sed -i 's:INSTALL_PATH= /usr/local/bin:INSTALL_PATH= /usr/bin:' Makefile

	emake || die
}

src_install () {
	dobin mp3gain
}
