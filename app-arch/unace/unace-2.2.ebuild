# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unace/unace-2.2.ebuild,v 1.10 2004/04/27 16:23:50 aliz Exp $

DESCRIPTION="ACE unarchiver"
HOMEPAGE="http://www.winace.com/"
SRC_URI="http://www.maxeline.com/winace/linunace${PV//.}.tgz"
IUSE=""
LICENSE="freedist"
SLOT="0"
KEYWORDS="-* x86 amd64 s390"

DEPEND="virtual/glibc"

S=${WORKDIR}

src_install() {
	into /opt/
	dobin unace
}
