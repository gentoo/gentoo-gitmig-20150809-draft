# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xwrits/xwrits-2.21.ebuild,v 1.13 2005/08/07 12:53:04 hansmi Exp $

DESCRIPTION="Xwrits reminds you to take wrist breaks, which will hopefully help you prevent repetitive stress injury."
HOMEPAGE="http://www.lcdf.org/xwrits/"
SRC_URI="http://www.lcdf.org/xwrits/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ppc sparc x86"
IUSE=""

DEPEND="virtual/x11"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc GESTURES NEWS README
}
