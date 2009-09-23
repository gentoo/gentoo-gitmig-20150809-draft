# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/eps/eps-1.5.ebuild,v 1.4 2009/09/23 19:06:13 patrick Exp $

DESCRIPTION="Inter7 Email Processing and mht System library"
HOMEPAGE="http://www.inter7.com/eps"
SRC_URI="http://www.inter7.com/eps/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""
DEPEND="sys-apps/sed"
RDEPEND=""

src_compile() {
	sed -i -e 's/\/usr/\$\(DESTDIR\)\$\(prefix\)/g' \
	    -e 's/\-O3/\$\(CFLAGS\)/g' \
	    -e 's/cp -pf/cp -f/g' \
	    Makefile

	make || die "compile failed"
}

src_install() {
	make prefix=/usr DESTDIR=${D} install || die "install failed"
	dodoc ChangeLog TODO doc/*
}
