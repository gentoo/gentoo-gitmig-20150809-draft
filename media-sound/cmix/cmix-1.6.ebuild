# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cmix/cmix-1.6.ebuild,v 1.11 2004/07/06 07:16:14 eradicator Exp $

IUSE=""

DESCRIPTION="command line audio mixer"
HOMEPAGE="http://cmix.sourceforge.net/"
SRC_URI="http://antipoder.dyndns.org/downloads/${P}.tbz2"

LICENSE="GPL-2"
SLOT="0"
#-amd64: 1.6: 'cmix list' gives: MIXER_READ(SOUND_MIXER_OUTSRC): Input/output error 
KEYWORDS="x86 sparc -amd64"

DEPEND="virtual/libc"

src_compile() {
	make || die
}

src_install() {
	einstall || die
	dobin cmix
	dodoc COPYING README || die
}
