# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/ccsh/ccsh-0.0.4-r2.ebuild,v 1.16 2004/06/29 03:52:15 vapier Exp $

DESCRIPTION="UNIX Shell for people already familiar with the C language"
HOMEPAGE="http://ccsh.sourceforge.net/"
SRC_URI="http://download.sourceforge.net/ccsh/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	make CFLAGS="${CFLAGS}" all || die
}

src_install() {
	into /
	dobin ccsh || die
	into /usr
	newman ccsh.man ccsh.1
	dodoc ChangeLog README TODO
}
