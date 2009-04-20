# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/liblist/liblist-2.1.ebuild,v 1.1 2009/04/20 05:44:09 nerdboy Exp $

inherit eutils toolchain-funcs

DESCRIPTION="This package provides generic linked-list manipulation routines, plus queues and stacks."
HOMEPAGE="http://www.gentoogeek.org/viewvc/C/liblist/"
SRC_URI="http://www.gentoogeek.org/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc examples"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s:/usr/lib:/usr/$(get_libdir):g" Makefile \
	    examples/cache/Makefile || die "sed 1 failed"
}

src_compile() {
	make CC="$(tc-getCC)" || die "make failed"
}

src_install() {
	newman list.3 llist.3
	newman stack.man lstack.3
	newman queue.man lqueue.3
	dolib.a liblist.a
	insinto /usr/include
	doins list.h queue.h stack.h
	dodoc README

	if use examples; then
	    dolib.a examples/cache/libcache.a
	    dobin examples/cache/cachetest
	    newman cache.3 lcache.3
	    insinto /usr/share/doc/${P}/examples
	    doins examples/{*.c,Makefile,README}
	    insinto /usr/share/doc/${P}/examples/cache
	    doins examples/cache/{*.c,Makefile,README}
	    doins
	fi

	if use doc; then
	    insinto /usr/share/doc/${P}
	    doins paper/paper.ps
	fi
}

pkg_postinst() {
	elog "Note the man pages for this package have been renamed to avoid"
	elog "name collisions with some system functions, however, the libs"
	elog "and header files have not been changed."
	elog "The new names are llist, lcache, lqueue, and lstack."
}
