# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nstats/nstats-0.4.ebuild,v 1.10 2005/04/17 17:02:16 vanquirius Exp $

inherit eutils

DESCRIPTION="Displays statistics about ethernet traffic including protocol breakdown"
SRC_URI="http://trash.net/~reeler/nstats/files/${P}.tar.gz"
HOMEPAGE="http://trash.net/~reeler/nstats/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 sparc"
IUSE=""

DEPEND="virtual/libpcap"

src_unpack(){
	unpack ${A}
	#rename bmon to bmon.nstats to avoid conflict with net-analyzer/bmon
	epatch ${FILESDIR}/${P}-makefile.patch
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc BUGS COPYING doc/TODO doc/ChangeLog
}
