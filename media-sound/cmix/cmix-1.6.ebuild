# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cmix/cmix-1.6.ebuild,v 1.10 2004/07/01 07:55:57 eradicator Exp $

IUSE=""

DESCRIPTION="command line audio mixer"
HOMEPAGE="http://cmix.sourceforge.net/"
SRC_URI="http://antipoder.dyndns.org/downloads/${P}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"

DEPEND="virtual/libc"

src_compile() {
	make || die
}

src_install() {
	einstall || die
	dobin cmix
	dodoc COPYING README || die
}
