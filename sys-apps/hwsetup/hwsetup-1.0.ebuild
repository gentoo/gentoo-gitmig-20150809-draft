# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hwsetup/hwsetup-1.0.ebuild,v 1.4 2003/06/21 21:19:40 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Hardware setup program"
SRC_URI="mirror://gentoo/hwsetup_1.0-9.tar.gz"
HOMEPAGE="http://www.knopper.net"

KEYWORDS="x86 amd64 -ppc -sparc -alpha -mips"
SLOT="0"
LICENSE="GPL-2"

DEPEND="sys-apps/kudzu"
RDEPEND="virtual/glibc"
src_unpack() {
    unpack ${A}
}


src_compile() {
	
	emake  || die
}

src_install() {
	einstall DESTDIR=${D} PREFIX=/usr MANDIR=/usr/share/man || die "Install failed"

}

