# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xpad/xpad-1.4.ebuild,v 1.8 2004/01/05 13:09:50 weeve Exp $

DESCRIPTION="A GTK+ 2.0 based 'post-it' note system."
HOMEPAGE="http://xpad.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc  ppc"

DEPEND=">=x11-libs/gtk+-2.0.0"

SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

S=${WORKDIR}/${P}

src_compile() {
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc CHANGES COPYING README TODO
}
