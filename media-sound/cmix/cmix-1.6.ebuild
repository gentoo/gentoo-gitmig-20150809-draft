# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cmix/cmix-1.6.ebuild,v 1.12 2005/07/25 12:15:37 dholm Exp $

IUSE=""

DESCRIPTION="command line audio mixer"
HOMEPAGE="http://cmix.sourceforge.net/"
SRC_URI="http://antipoder.dyndns.org/downloads/${P}.tbz2"

LICENSE="GPL-2"
SLOT="0"
#-amd64: 1.6: 'cmix list' gives: MIXER_READ(SOUND_MIXER_OUTSRC): Input/output error 
KEYWORDS="-amd64 ~ppc sparc x86"

DEPEND="virtual/libc"

src_compile() {
	make || die
}

src_install() {
	einstall || die
	dobin cmix
	dodoc COPYING README || die
}
