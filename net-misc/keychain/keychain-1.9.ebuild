# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/keychain/keychain-1.9.ebuild,v 1.4 2002/08/14 12:08:08 murphy Exp $

DESCRIPTION="A front-end to ssh-agent"
HOMEPAGE="http://www.gentoo.org/projects/keychain/"

SRC_URI="http://www.ibiblio.org/gentoo/distfiles/${P}.tar.bz2"
S=${WORKDIR}/${P}
KEYWORDS="x86 ppc sparc sparc64"
LICENSE="GPL"
SLOT="0"

DEPEND="virtual/glibc"
RDEPEND="${DEPEND} sys-apps/bash net-misc/openssh"

src_install() {
	dobin keychain
	dodoc ChangeLog README
}
