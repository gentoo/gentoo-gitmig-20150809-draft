# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header

S=${WORKDIR}/${P}
DESCRIPTION="Program that displays information about your hardware"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://syscriptor.sourceforge.net/"
LICENSE="GPL-2"
KEYWORDS="~x86"
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
