# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/axel/axel-1.0a.ebuild,v 1.17 2004/10/23 05:55:16 mr_bones_ Exp $

DESCRIPTION="light Unix download accelerator"
HOMEPAGE="http://www.lintux.cx/axel.html"
SRC_URI="http://www.lintux.cx/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ppc ppc64 ppc-macos"
IUSE="debug"

DEPEND="virtual/libc"

src_compile() {
	cd work/${P}
	local myconf
	use debug && myconf="--debug=1 --strip=0"
	./configure \
		--prefix=/usr \
		--etcdir=/etc \
		--mandir=/usr/share/man \
		${myconf} \
		|| die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc API CHANGES COPYING CREDITS README axelrc.example
}
