# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libiconv/libiconv-1.7.ebuild,v 1.10 2002/12/09 04:21:03 manson Exp $

DESCRIPTION="This is a required for GTK+ in GNOME2"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/libiconv/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/libiconv/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc "

src_compile() {
	econf
	mv man/Makefile man/Makefile.orig
	sed -e 's/mkdir/$(MKDIR)/' man/Makefile.orig > man/Makefile
	emake || die
}

src_install() {
	make MKDIR="mkdir -p" DESTDIR=${D} install || die
}
