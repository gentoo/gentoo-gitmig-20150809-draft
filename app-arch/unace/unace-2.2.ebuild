# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unace/unace-2.2.ebuild,v 1.5 2003/07/08 21:50:26 darkspecter Exp $

S=${WORKDIR}
DESCRIPTION="ACE unarchiver"
SRC_URI="http://home.hccnet.nl/h.edskes/download/linunace${PV//./}.tgz"
HOMEPAGE="http://www.winace.com/"

SLOT="0"
LICENSE="freedist"
KEYWORDS="x86 -ppc -sparc "

DEPEND="virtual/glibc"

src_install() {
	into /opt
	dobin unace
}
