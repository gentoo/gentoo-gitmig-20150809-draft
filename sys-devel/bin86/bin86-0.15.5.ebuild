# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/bin86/bin86-0.15.5.ebuild,v 1.13 2004/01/07 20:59:51 gustavoz Exp $

S=${WORKDIR}/bin86
DESCRIPTION="Assembler and loader used to create kernel bootsector"
SRC_URI="http://www.cix.co.uk/~mayday/${P}.tar.gz"
HOMEPAGE="http://www.cix.co.uk/~mayday/"

DEPEND="virtual/glibc"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -sparc -ppc"

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
