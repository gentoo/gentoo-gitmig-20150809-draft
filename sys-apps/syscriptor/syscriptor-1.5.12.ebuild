# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/syscriptor/syscriptor-1.5.12.ebuild,v 1.9 2004/07/15 02:36:49 agriffis Exp $

DESCRIPTION="Program that displays information about your hardware"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://syscriptor.sourceforge.net/"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ~ppc"
SLOT="0"

IUSE=""

DEPEND="virtual/libc"

src_compile() {

	econf || die
	emake || die

}

src_install () {

	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING CREDITS ChangeLog HISTORY LICENSE NEWS README TODO
}
