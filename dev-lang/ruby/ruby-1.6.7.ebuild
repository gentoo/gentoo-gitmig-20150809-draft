# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ruby/ruby-1.6.7.ebuild,v 1.4 2002/08/14 11:58:50 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An object-oriented scripting language"
SRC_URI="ftp://ftp.ruby-lang.org/pub/ruby/${P}.tar.gz"
HOMEPAGE="http://www.ruby-lang.org/"
LICENSE="Ruby"
KEYWORDS="x86 sparc sparc64"
SLOT="0"

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/gdbm-1.8.0
	>=sys-libs/readline-4.1
	>=sys-libs/ncurses-5.2"

src_compile() {
	./configure --host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc COPYING* ChangeLog MANIFEST README* ToDo
}
