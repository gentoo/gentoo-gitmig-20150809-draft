# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <blutgens@sistina.com>
# $Header: /var/cvsroot/gentoo-x86/app-crypt/ssh-multiadd/ssh-multiadd-1.3.1.ebuild,v 1.3 2001/06/07 05:22:23 blutgens Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION=""
SRC_URI="http://www.azstarnet.com/~donut/programs/ssh-multiadd/${A}"
HOMEPAGE="http://www.azstarnet.com/~donut/programs/"

DEPEND=">=dev-lang/python-2.0-r3
	>=net-misc/x11-ssh-askpass-1.2.2"

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

