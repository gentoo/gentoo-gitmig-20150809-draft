# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/ne/ne-1.19.ebuild,v 1.2 2003/06/29 18:24:08 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="ne is the nice editor, easy to use for the beginner and powerful for the wizard"
SRC_URI="http://ne.dsi.unimi.it/${P}.tar.gz"
HOMEPAGE="http://ne.dsi.unimi.ti/"

DEPEND="ncurses? ( >=sys-libs/ncurses-5.2 )"
PROVIDE="virtual/editor"

SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"
IUSE="ncurses"

src_compile() {
	if [ "`use ncurses`" ]; then
		emake -C src ne CFLAGS="${CFLAGS} -DNODEBUG -D_POSIX_C_SOURCE=199506L" LIBS="-lncurses" || die
	else
		emake -C src net CFLAGS="${CFLAGS} -DNODEBUG -DTERMCAP -D_POSIX_C_SOURCE=199506L" LIBS="" || die
	fi
}

src_install() {
	gunzip doc/ne.info*gz

	into /usr

	dobin src/ne
	doman doc/ne.1
	doinfo doc/*.info*
	dohtml doc/*.html
	dodoc CHANGES COPYING README
	dodoc doc/*.txt doc/*.ps doc/*.texinfo doc/default.*
}

