# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/bin86/bin86-0.15.5.ebuild,v 1.16 2004/07/15 03:08:36 agriffis Exp $

S=${WORKDIR}/bin86
DESCRIPTION="Assembler and loader used to create kernel bootsector"
SRC_URI="http://www.cix.co.uk/~mayday/${P}.tar.gz"
HOMEPAGE="http://www.cix.co.uk/~mayday/"

DEPEND="virtual/libc"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -sparc -ppc"
IUSE=""

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/bin86-0.15.4-Makefile-gentoo.diff || die
}

src_compile() {

	make ${MAKEOPTS} || die

}

src_install() {

	make DESTDIR=${D} install || die

	dodoc README README-0.4 ChangeLog
	docinto as
	dodoc as/COPYING as/TODO
}
