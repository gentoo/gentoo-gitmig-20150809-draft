# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/time/time-1.7.ebuild,v 1.10 2004/07/15 02:41:35 agriffis Exp $

DESCRIPTION="A command that displays info about resources used by a program"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/time/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/directory/time.html"
KEYWORDS="x86 amd64"
IUSE=""
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/libc"

src_compile() {
	./configure --prefix=/usr \
		--mandir=/usr/share/man || die
	emake || die
}

src_install() {
	make prefix=${D}/usr sysconfdir=${D}/etc mandir=${D}/usr/share/man install || die
	dodoc ChangeLog COPYING README
	dodoc AUTHORS NEWS
}
