# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.8 2002/05/30 01:54:49 sandymac Exp

DESCRIPTION="libavc1394 is a programming interface for the 1394 Trade Association AV/C (Audio/Video Control) Digital Interface Command Set."
HOMEPAGE="http://sourceforge.net/projects/libavc1394/"
LICENSE="LGPL"
SRC_URI="http://telia.dl.sourceforge.net/sourceforge/libavc1394/${P}.tar.gz"
S=${WORKDIR}/${P}

DEPEND=">=libraw1394-0.8"
RDEPEND="${DEPEND}"
SLOT="0"
KEYWORDS="x86 ppc"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
