# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-arch/unace/unace-2.0.4.ebuild,v 1.8 2002/09/02 01:52:26 rphillips Exp $

S=${WORKDIR}
DESCRIPTION="ACE unarchiver"
SRC_URI="http://www.vikingassociates.com/winace/linunace204.tgz"
HOMEPAGE="http://www.winace.com/"

SLOT="0"
LICENSE="freedist"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="virtual/glibc"

src_install () {
	into /opt
	dobin unace
}
