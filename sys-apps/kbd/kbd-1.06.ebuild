# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kbd/kbd-1.06.ebuild,v 1.3 2002/04/27 23:34:20 bangert Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Keyboard and console utilities"
SRC_URI="ftp://ftp.win.tue.nl/pub/home/aeb/linux-local/utils/kbd/${P}.tar.gz"
HOMEPAGE=""
DEPEND="virtual/glibc"
PROVIDE="sys-apps/console-tools"
src_compile() {
	./configure --mandir=/usr/share/man --datadir=/usr/share
	make
}

src_install() {
	make DESTDIR=${D} DATADIR=${D}/usr/share MANDIR=${D}/usr/share/man install
}
