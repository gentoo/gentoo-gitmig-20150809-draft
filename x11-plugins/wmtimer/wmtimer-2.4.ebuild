# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmtimer/wmtimer-2.4.ebuild,v 1.10 2004/01/04 18:36:48 aliz Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Dockable clock which can run in alarm, countdown timer or chronograph mode"
SRC_URI="http://home.dwave.net/~jking/wmtimer/${P}.tar.gz"
HOMEPAGE="http://home.dwave.net/~jking/wmtimer/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64"

DEPEND="virtual/glibc
	virtual/x11
	=x11-libs/gtk+-1.2*"

src_unpack() {
	unpack ${A} ; cd ${S}/wmtimer
	sed -i -e "s:-O2 -Wall:${CFLAGS}:" Makefile
}

src_compile() {
	emake || die
}

src_install () {

	cd ${S2}
	dobin wmtimer

	cd ${S}
	dodoc README COPYING INSTALL CREDITS INSTALL Changelog

}
