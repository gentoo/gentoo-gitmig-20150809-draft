# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kbd/kbd-1.06.ebuild,v 1.4 2002/07/14 19:20:18 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Keyboard and console utilities"
SRC_URI="ftp://ftp.win.tue.nl/pub/home/aeb/linux-local/utils/kbd/${P}.tar.gz"
HOMEPAGE=""
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"
DEPEND="virtual/glibc"
PROVIDE="sys-apps/console-tools"
src_compile() {
	./configure --mandir=/usr/share/man --datadir=/usr/share
	make
}

src_install() {
	make DESTDIR=${D} DATADIR=${D}/usr/share MANDIR=${D}/usr/share/man install
}
