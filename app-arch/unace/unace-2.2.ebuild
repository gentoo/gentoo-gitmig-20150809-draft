# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unace/unace-2.2.ebuild,v 1.1 2002/11/29 18:15:52 vapier Exp $

S=${WORKDIR}
DESCRIPTION="ACE unarchiver"
SRC_URI="http://home.hccnet.nl/h.edskes/download/linunace${PV//./}.tgz"
HOMEPAGE="http://www.winace.com/"

SLOT="0"
LICENSE="freedist"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="virtual/glibc"

src_install() {
	into /opt
	dobin unace
}
