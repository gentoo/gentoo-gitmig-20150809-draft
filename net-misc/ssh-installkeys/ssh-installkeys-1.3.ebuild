# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ssh-installkeys/ssh-installkeys-1.3.ebuild,v 1.1 2004/06/05 16:47:27 jmglov Exp $

DESCRIPTION="This script tries to export ssh public keys to a specified site. It will walk you through generating key pairs if it doesn't find any to export."
HOMEPAGE="http://www.catb.org/~esr/${PN}/"
SRC_URI="http://www.catb.org/~esr/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND=">=virtual/python-2.3"

DEPEND="${RDEPEND}"

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	doman ssh-installkeys.1
	dodoc COPYING README freshmeat-submit.xml
	dobin ssh-installkeys
}
