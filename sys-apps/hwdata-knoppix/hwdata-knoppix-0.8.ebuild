# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hwdata-knoppix/hwdata-knoppix-0.8.ebuild,v 1.4 2003/08/11 17:40:44 wwoods Exp $

S=${WORKDIR}/${P}
DESCRIPTION="data hwsetup program"
SRC_URI="http://www.knopper.net/download/knoppix/hwdata-knoppix_0.8-3.tar.gz"
HOMEPAGE="http://www.knopper.net"

KEYWORDS="x86 amd64 -ppc -sparc alpha -mips"
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

