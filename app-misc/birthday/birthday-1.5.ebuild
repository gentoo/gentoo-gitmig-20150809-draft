# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/birthday/birthday-1.5.ebuild,v 1.6 2004/04/06 23:12:27 weeve Exp $

DESCRIPTION="Displays a list of events happening in the near future"
HOMEPAGE="http://users.zetnet.co.uk/mortia/source/"
SRC_URI="http://users.zetnet.co.uk/mortia/source/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"
IUSE=""
DEPEND="sys-libs/glibc"

src_compile() {
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}


