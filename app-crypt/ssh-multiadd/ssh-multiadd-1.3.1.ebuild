# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-crypt/ssh-multiadd/ssh-multiadd-1.3.1.ebuild,v 1.7 2002/07/11 06:30:11 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION=""
SRC_URI="http://www.azstarnet.com/~donut/programs/ssh-multiadd/${P}.tar.gz"
HOMEPAGE="http://www.azstarnet.com/~donut/programs/"
LICENSE="GPL-2"

DEPEND=">=dev-lang/python-2.0-r3
	X? ( >=net-misc/x11-ssh-askpass-1.2.2 )"

#lamer: pulling x11-ssh-askpass in pulls in X, which is bad for servers
#so I added the X? ( ) -- drobbins

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

