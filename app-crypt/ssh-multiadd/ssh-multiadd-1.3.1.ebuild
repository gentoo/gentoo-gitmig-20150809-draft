# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/app-crypt/ssh-multiadd/ssh-multiadd-1.3.1.ebuild,v 1.1 2001/06/04 19:37:29 blutgens Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION=""
SRC_URI="http://www.azstarnet.com/~donut/programs/ssh-multiadd/${A}"
HOMEPAGE="http://www.azstarnet.com/~donut/programs/"

DEPEND=""

src_unpack() {

   unpack ${A}
   cd ${S}
   patch -p0 < ${FILESDIR}/ssh-multiadd-1.3.1.diff
}

src_install () {

    dobin ssh-multiadd
    doman ssh-multiadd.1
    dodoc COPYING ChangeLog README todo

}

