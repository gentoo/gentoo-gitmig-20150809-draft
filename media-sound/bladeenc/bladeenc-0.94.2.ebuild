# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/bladeenc/bladeenc-0.94.2.ebuild,v 1.4 2002/08/14 08:47:00 pvdabeel Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An mp3 encoder"
SRC_URI="http://bladeenc.mp3.no/source/${P}-src-stable.tar.gz"
HOMEPAGE="http://bladeenc.mp3.no/deenc.mp3.no/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="virtual/glibc"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING INSTALL README TODO
}
