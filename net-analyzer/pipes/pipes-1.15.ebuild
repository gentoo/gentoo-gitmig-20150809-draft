# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/pipes/pipes-1.15.ebuild,v 1.2 2003/09/22 19:11:26 msterret Exp $

DESCRIPTION="Very versatile TCP pipes"
HOMEPAGE="http://bisqwit.iki.fi/source/pipes.html"
SRC_URI="http://bisqwit.iki.fi/src/arch/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i "s:-O2:${CFLAGS}:" Makefile
	touch .depend
}

src_compile() {
	emake || die
}

src_install() {
	dobin plis
	dohard /usr/bin/plis /usr/bin/pcon
	dodoc Examples ChangeLog
	dohtml README.html
}
