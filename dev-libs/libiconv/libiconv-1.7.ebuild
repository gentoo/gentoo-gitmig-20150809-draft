# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libiconv/libiconv-1.7.ebuild,v 1.17 2004/07/14 14:40:21 agriffis Exp $

DESCRIPTION="This is a fork of the glibc iconv implementation that is incompatible. it may break things."
SRC_URI="ftp://ftp.gnu.org/pub/gnu/libiconv/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/libiconv/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc ppc"
IUSE=""

src_compile() {
	econf || die "econf failed"
	mv man/Makefile man/Makefile.orig
	sed -e 's/mkdir/$(MKDIR)/' man/Makefile.orig > man/Makefile
	emake || die
}

src_install() {
	make MKDIR="mkdir -p" DESTDIR=${D} install || die
}
