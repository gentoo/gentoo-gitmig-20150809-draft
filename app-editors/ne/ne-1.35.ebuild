# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/ne/ne-1.35.ebuild,v 1.1 2004/07/31 14:18:53 zul Exp $

DESCRIPTION="the nice editor, easy to use for the beginner and powerful for the wizard"
HOMEPAGE="http://ne.dsi.unimi.it/"
SRC_URI="http://ne.dsi.unimi.it/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="ncurses"

DEPEND="ncurses? ( >=sys-libs/ncurses-5.2 )"
PROVIDE="virtual/editor"

src_compile() {
	if use ncurses ; then
		emake -C src ne CFLAGS="${CFLAGS} -DNODEBUG -D_POSIX_C_SOURCE=199506L" LIBS="-lncurses" || die
	else
		emake -C src net CFLAGS="${CFLAGS} -DNODEBUG -DTERMCAP -D_POSIX_C_SOURCE=199506L" LIBS="" || die
	fi
}

src_install() {
	gunzip doc/ne.info*gz

	into /usr

	dobin src/ne || die
	doman doc/ne.1
	doinfo doc/*.info*
	dohtml doc/*.html
	dodoc CHANGES README
	dodoc doc/*.txt doc/*.ps doc/*.texinfo doc/default.*
}
