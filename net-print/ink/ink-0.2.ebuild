# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/ink/ink-0.2.ebuild,v 1.2 2003/10/31 13:37:46 lanius Exp $

DESCRIPTION="A command line utility to display the ink level of your printer"
SRC_URI="http://home.arcor.de/markusheinz/${P}.tar.gz"
HOMEPAGE="http://home.arcor.de/markusheinz/ink.html"

SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"

DEPEND=">=net-print/libinklevel-0.5"

S=${WORKDIR}/${PN}

src_install () {
	make DESTDIR=${D}/usr install || die
	dodoc COPYING README
}
