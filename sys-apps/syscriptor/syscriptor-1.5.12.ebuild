# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/syscriptor/syscriptor-1.5.12.ebuild,v 1.5 2003/09/07 00:58:44 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Program that displays information about your hardware"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://syscriptor.sourceforge.net/"
LICENSE="GPL-2"
KEYWORDS="x86 amd64"
SLOT="0"

IUSE=""

DEPEND="virtual/glibc"

src_compile() {

	econf || die
	emake || die

}

src_install () {

	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING CREDITS ChangeLog HISTORY LICENSE NEWS README TODO
}
