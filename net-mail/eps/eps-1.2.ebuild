# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/eps/eps-1.2.ebuild,v 1.4 2004/11/24 09:44:17 ticho Exp $

DESCRIPTION="Inter7 Email Processing and mht System library"
HOMEPAGE="http://www.inter7.com/eps"
SRC_URI="http://www.inter7.com/eps/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""
DEPEND="virtual/libc
	sys-apps/sed"
RDEPEND="virtual/libc"

src_compile() {
	sed -e 's/\/usr/\$\(DESTDIR\)\$\(prefix\)/g' -e 's/\-O3/\$\(CFLAGS\)/g' Makefile > Makefile.new && mv Makefile.new Makefile
	make || die "compile failed"
}

src_install() {
	make prefix=/usr DESTDIR=${D}../image install || die "install failed"
}
