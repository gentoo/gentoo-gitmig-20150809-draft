# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/tnef/tnef-1.1.1.ebuild,v 1.9 2003/02/13 14:42:44 vapier Exp $

DESCRIPTION="Decodes MS-TNEF MIME attachments"
SRC_URI="http://world.std.com/~damned/${P}.tar.gz"
HOMEPAGE="http://world.std.com/~damned/software.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"

DEPEND="virtual/glibc"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS ChangeLog COPYING NEWS README TODO
	rm -rf ${D}/usr/man
	doman doc/tnef.1
}
