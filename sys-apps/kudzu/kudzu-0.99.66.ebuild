# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kudzu/kudzu-0.99.66.ebuild,v 1.1 2003/03/03 05:05:31 livewire Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Redhats Hardware detection"
SRC_URI="http://www.knopper.net/download/knoppix/${P}.tar.gz"
HOMEPAGE="http://www.knopper.net"

KEYWORDS="~x86 -ppc -sparc -alpha -mips"
SLOT="0"
LICENSE="GPL"

DEPEND=">=dev-libs/dietlibc-0.20"
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

