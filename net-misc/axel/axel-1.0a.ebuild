# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/axel/axel-1.0a.ebuild,v 1.8 2003/02/13 14:45:28 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Axel: A light Unix download accelerator"
HOMEPAGE="http://www.lintux.cx/axel.html"
SRC_URI="http://www.lintux.cx/downloads/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

DEPEND="virtual/glibc"

src_compile() {
	local mconf
	cd work/${P}
	( [ -n "$DEBUG" ] || [ -n "$DEBUGBUILD" ] ) && \
		myconf="${myconf} --debug=1 --strip=0"
	./configure --prefix=/usr \
		--etcdir=/etc \
		--mandir=/usr/share/man $myconf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc API CHANGES COPYING CREDITS README axelrc.example
}
