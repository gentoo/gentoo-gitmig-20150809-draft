# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/keychain/keychain-2.0.2.ebuild,v 1.4 2002/12/16 21:58:45 drobbins Exp $

DESCRIPTION="A front-end to ssh-agent"
HOMEPAGE="http://www.gentoo.org/projects/keychain/"

SRC_URI="http://www.ibiblio.org/gentoo/distfiles/${P}.tar.bz2"
S=${WORKDIR}/${P}
KEYWORDS="x86 ppc sparc "
LICENSE="GPL"
SLOT="0"

DEPEND="virtual/glibc"
RDEPEND="${DEPEND} sys-apps/bash net-misc/openssh sys-apps/sh-utils"

src_install() {
	dobin keychain
	dodoc ChangeLog README
}
