# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/resid/resid-0.13-r1.ebuild,v 1.5 2004/03/19 07:56:04 mr_bones_ Exp $

DESCRIPTION="C++ library to emulate the C64 SID chip"
HOMEPAGE="http://sidplay2.sourceforge.net"
SRC_URI="mirror://sourceforge/sidplay2/${P}-p1.tgz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="x86 ~sparc "
DEPEND="virtual/glibc"
S=${WORKDIR}/${P}

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
