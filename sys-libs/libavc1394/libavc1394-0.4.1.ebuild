# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header : $

DESCRIPTION="libavc1394 is a programming interface for the 1394 Trade Association AV/C (Audio/Video Control) Digital Interface Command Set."
HOMEPAGE="http://sourceforge.net/projects/libavc1394/"
LICENSE="LGPL"
SRC_URI="mirror://sourceforge/libavc1394/${P}.tar.gz"
S=${WORKDIR}/${P}

DEPEND=">=libraw1394-0.8"
SLOT="0"
KEYWORDS="~x86 ~ppc"

src_compile() {
	econf || die	
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
