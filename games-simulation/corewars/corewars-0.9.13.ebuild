# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/corewars/corewars-0.9.13.ebuild,v 1.2 2004/02/20 07:33:25 mr_bones_ Exp $

DESCRIPTION="Simulation game involving virtual machine code"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://corewars.sourceforge.net/"

KEYWORDS="x86 ~ppc"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/x11
	virtual/glibc
	>=dev-libs/glib-1.2.10-r1
	=x11-libs/gtk+-1.2*"

src_compile() {
	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info || die

	emake || die
}

src_install() {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	dodoc ChangeLog COPYING README TODO DIFFERENCES INTERESTING-COMBINATIONS
}
