# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cmix/cmix-1.6.ebuild,v 1.1 2003/03/04 22:17:50 agenkin Exp $

DESCRIPTION="cmix is a command line audio mixer :D"
HOMEPAGE="http://cmix.sourceforge.net/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/glibc"

SRC_URI="http://antipoder.dyndns.org/downloads/${P}.tbz2"
S=${WORKDIR}/${P}

src_unpack() {
	
	unpack ${A}
	cd ${S}
}

src_compile() {

	make || die
}

src_install() {

	einstall
	dobin cmix
	dodoc COPYING README || die
}			
