# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Joshua Pollak <pardsbane@offthehill.org>
# /home/cvsroot/gentoo-x86/sys-apps/less/less-358-r2.ebuild,v 1.1 2001/02/07 15:51:27 achim Exp

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Extracts files from Microsoft .cab files."
SRC_URI="http://www.kyz.uklinux.net/downloads/${A}"
HOMEPAGE="http://www.kyz.uklinux.net/cabextract.php3"

DEPEND=""

src_compile() {

    try ./configure --host=${CHOST} --prefix=/usr --mandir=/usr/share/man
    try pmake

}

src_install() {

	dobin cabextract

	doman cabextract.1

	dodoc COPYING NEWS README TODO AUTHORS
}




