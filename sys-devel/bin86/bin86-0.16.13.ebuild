# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/bin86/bin86-0.16.13.ebuild,v 1.8 2004/11/30 02:37:06 vapier Exp $

DESCRIPTION="Assembler and loader used to create kernel bootsector"
HOMEPAGE="http://www.cix.co.uk/~mayday/"
SRC_URI="http://www.cix.co.uk/~mayday/${PN/bin/dev}/${P}.tar.gz
	mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	sys-apps/sed"

src_compile() {
	emake PREFIX="/usr" CFLAGS="${CFLAGS} -D_POSIX_SOURCE" || die
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man/man1

	einstall PREFIX="${D}/usr" MANDIR="${D}/usr/share/man/man1" || die

	dodoc README README-0.4 ChangeLog
	docinto as
}
