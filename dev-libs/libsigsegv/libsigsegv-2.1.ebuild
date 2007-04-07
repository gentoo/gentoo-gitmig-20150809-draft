# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libsigsegv/libsigsegv-2.1.ebuild,v 1.8 2007/04/07 16:36:15 opfer Exp $

inherit eutils

DESCRIPTION="GNU libsigsegv is a library for handling page faults in user mode."
HOMEPAGE="ftp://ftp.gnu.org/pub/gnu/libsigsegv/"
SRC_URI="mirror://gnu/libsigsegv/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~ppc-macos"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	if use ppc-macos ; then
		epatch ${FILESDIR}/libsigsegv-2.1-darwin-7.x.patch || die
		./configure --enable-shared || die
	else
		econf --enable-shared || die
	fi
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog* INSTALL NEWS PORTING README*
}
