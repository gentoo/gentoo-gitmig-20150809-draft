# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/i810switch/i810switch-0.3.ebuild,v 1.1 2003/07/21 19:22:25 twp Exp $

DESCRIPTION="A utility for switching the LCD and external VGA displays on and off"
HOMEPAGE="http://vorlon.ces.cwru.edu/~ames/i810switch/"
SRC_URI="http://vorlon.ces.cwru.edu/~ames/i810switch/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~arm ~hppa ~mips ~sparc ~x86"
IUSE=""
DEPEND="virtual/glibc"

src_compile()
{
	dosed /^PATH=.*/d i810rotate
	gcc ${CFLAGS} -o i810switch i810switch.c || die
}

src_install()
{
	dobin i810rotate i810switch
	dodoc AUTHORS ChangeLog README TODO
}
