# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cmix/cmix-1.6.ebuild,v 1.2 2003/04/25 14:27:19 vapier Exp $

DESCRIPTION="command line audio mixer"
HOMEPAGE="http://cmix.sourceforge.net/"
SRC_URI="http://antipoder.dyndns.org/downloads/${P}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/glibc"

src_compile() {
	make || die
}

src_install() {
	einstall || die
	dobin cmix
	dodoc COPYING README || die
}			
