# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Michael Conrad Tilstra <michael@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/boxes/boxes-1.0.1.ebuild,v 1.2 2001/06/07 01:45:52 achim Exp $

A=${P}.src.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="boxes draws any kind of boxes around your text!"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/utils/text/${A}"
HOMEPAGE="http://www6.informatik.uni-erlangen.de/~tsjensen/boxes/"
DEPEND="virtual/glibc"

src_unpack() {
   unpack ${A}
   cd ${S}
   try patch -p1 < ${FILESDIR}/${P}-gentoo.diff
   cd src

}


src_compile() {
   try make clean
   try make CFLAGS=\"$CFLAGS -I. -Iregexp\"
}

src_install() {

   dobin src/boxes
   doman doc/boxes.1
   dodoc README* COPYING 
   insinto /usr/share/boxes
   doins boxes-config
}

