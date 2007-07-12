# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libax25/libax25-0.0.11-r1.ebuild,v 1.6 2007/07/12 02:25:34 mr_bones_ Exp $

DESCRIPTION="AX.25 protocol library for various Amateur Radio programs"
HOMEPAGE="http://ax25.sourceforge.net/"
SRC_URI="mirror://sourceforge/ax25/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="virtual/libc"

src_install() {
	make DESTDIR=${D} install installconf || die
	dodoc AUTHORS COPYING NEWS README
}
