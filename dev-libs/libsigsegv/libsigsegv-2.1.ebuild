# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libsigsegv/libsigsegv-2.1.ebuild,v 1.4 2004/10/16 05:47:27 ndimiduk Exp $

DESCRIPTION="GNU libsigsegv is a library for handling page faults in user mode."
HOMEPAGE="ftp://ftp.gnu.org/pub/gnu/libsigsegv/"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/libsigsegv/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~ppc-macos"
IUSE=""

DEPEND="virtual/libc"

inherit eutils

src_compile() {
	use ppc-macos && \
		epatch ${FILESDIR}/libsigsegv-2.1-darwin-7.x.patch
	econf --enable-shared || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog* INSTALL NEWS PORTING README*
}
