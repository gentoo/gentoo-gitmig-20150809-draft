# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/bin86/bin86-0.16.13.ebuild,v 1.2 2004/01/07 20:59:51 gustavoz Exp $

IUSE=

S="${WORKDIR}/${P}"
DESCRIPTION="Assembler and loader used to create kernel bootsector"
SRC_URI="http://www.cix.co.uk/~mayday/${PN/bin/dev}/${P}.tar.gz"
HOMEPAGE="http://www.cix.co.uk/~mayday/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 -sparc -ppc"

DEPEND="virtual/glibc sys-apps/sed"
RDEPEND="virtual/glibc"

src_compile() {
	emake PREFIX="/usr" CFLAGS="${CFLAGS} -D_POSIX_SOURCE" || die
}

src_install() {

	dodir /usr/bin
	dodir /usr/share/man/man1

	einstall PREFIX="${D}/usr" MANDIR="${D}/usr/share/man/man1"

	dodoc README README-0.4 ChangeLog
	docinto as
	dodoc as/COPYING
}
