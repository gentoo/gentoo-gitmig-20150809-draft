# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-crypt/ssh-multiadd/ssh-multiadd-1.3.1.ebuild,v 1.10 2002/08/16 02:36:53 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="adds multiple ssh keys to the ssh authentication agent. These may use the same passphrase. Unlike ssh-add, if any of the keys use the same passphrase, you will only need to enter each unique passphrase once, and keys that are already added will not be prompted for again."
SRC_URI="http://www.azstarnet.com/~donut/programs/ssh-multiadd/${P}.tar.gz"
HOMEPAGE="http://www.azstarnet.com/~donut/programs/index_s.html#ssh-multiadd"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

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
