# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/ne/ne-1.35.ebuild,v 1.4 2004/09/07 23:06:53 swegener Exp $

DESCRIPTION="the nice editor, easy to use for the beginner and powerful for the wizard"
HOMEPAGE="http://ne.dsi.unimi.it/"
SRC_URI="http://ne.dsi.unimi.it/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="ncurses"

DEPEND="ncurses? ( >=sys-libs/ncurses-5.2 )"
PROVIDE="virtual/editor"

src_compile() {
	if use ncurses
	then
		emake -C src ne CFLAGS="${CFLAGS} -DNODEBUG -D_POSIX_C_SOURCE=199506L" LIBS="-lncurses" || die "emake failed"
	else
		emake -C src net CFLAGS="${CFLAGS} -DNODEBUG -DTERMCAP -D_POSIX_C_SOURCE=199506L" LIBS="" || die "emake failed"
	fi
}

src_install() {
	gunzip doc/ne.info*.gz || die "gunzip failed"

	dobin src/ne || die "dobin failed"
	doman doc/ne.1 || die "doman failed"
	doinfo doc/*.info* || die "doinfo failed"
	dohtml doc/*.html || die "dohtml failed"
	dodoc \
		CHANGES README \
		doc/*.txt doc/*.ps doc/*.pdf doc/*.texinfo doc/default.* \
		|| die "dodoc failed"
}
