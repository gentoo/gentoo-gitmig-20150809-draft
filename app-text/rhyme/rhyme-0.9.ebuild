# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/rhyme/rhyme-0.9.ebuild,v 1.6 2004/10/16 19:31:06 vapier Exp $

inherit ccc

DESCRIPTION="Console based Rhyming Dictionary"
HOMEPAGE="http://rhyme.sourceforge.net/"
SRC_URI="mirror://sourceforge/rhyme/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 alpha"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.3
	>=sys-libs/readline-4.3
	>=sys-libs/gdbm-1.8.0"

src_compile() {
	# gcc is hardcoded, switch to user specified compiler
	replace-cc-hardcode

	# CFLAGS are hardcoded, replace with user specified flags
	sed -i "s#\(^FLAGS =\).*#\1 ${CFLAGS}#g" ${S}/Makefile

	# termcap is used by default, switch to ncurses
	sed -i 's/-ltermcap/-lncurses/g' ${S}/Makefile

	# works fine with parallel build
	emake || die
}

src_install() {
	# author doesnt use -D for install
	dodir /usr/share/rhyme /usr/bin /usr/share/man/man1

	einstall BINPATH=${D}/usr/bin \
			MANPATH=${D}/usr/share/man/man1 \
			RHYMEPATH=${D}/usr/share/rhyme

	dodoc INSTALL

	prepallman
}
