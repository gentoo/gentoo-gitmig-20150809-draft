# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/pfqueue/pfqueue-0.5.6.ebuild,v 1.4 2007/08/13 21:43:20 dertobi123 Exp $

inherit eutils toolchain-funcs

DESCRIPTION="pfqueue is an ncurses console-based tool for managing Postfix
queued messages"
HOMEPAGE="http://pfqueue.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""
DEPEND="virtual/libc
		sys-devel/libtool
		sys-libs/ncurses"

src_compile() {
	econf || die "econf failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README ChangeLog NEWS TODO AUTHORS
}
