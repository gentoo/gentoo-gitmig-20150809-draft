# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/bin86/bin86-0.16.0.ebuild,v 1.8 2004/06/24 22:43:08 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Assembler and loader used to create kernel bootsector"
SRC_URI="http://www.cix.co.uk/~mayday/${PN/bin/dev}/${P}.tar.bz2"
HOMEPAGE="http://www.cix.co.uk/~mayday/"

DEPEND="virtual/glibc"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -sparc -ppc"

src_compile() {

	emake PREFIX="/usr"|| die

}

src_install() {

	dodir /usr/bin
	dodir /usr/share/man/man1

	einstall PREFIX="${D}/usr" MANDIR="${D}/usr/share/man/man1"

	dodoc README README-0.4 ChangeLog
	docinto as
	dodoc as/COPYING as/TODO
}
