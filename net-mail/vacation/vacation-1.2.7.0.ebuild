# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/vacation/vacation-1.2.7.0.ebuild,v 1.1 2008/07/31 07:32:12 phosphan Exp $

inherit toolchain-funcs

DESCRIPTION="automatic mail answering program"
HOMEPAGE="http://vacation.sourceforge.net/"
SRC_URI="mirror://sourceforge/vacation/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~x86"
SLOT="0"
IUSE=""

RDEPEND="virtual/mta
	sys-libs/gdbm"
DEPEND="${RDEPEND}
	!mail-mta/sendmail"

src_compile () {
	emake CC=$(tc-getCC) ARCH=$(tc-arch-kernel) CFLAGS="${CFLAGS} -DMAIN" || die "emake failed."
}

src_install () {
	dodir /usr/bin
	dodir /usr/man/man1
	make BINDIR="${D}usr/bin" MANDIR="${D}usr/man/man" install || die
"make install failed"
}
