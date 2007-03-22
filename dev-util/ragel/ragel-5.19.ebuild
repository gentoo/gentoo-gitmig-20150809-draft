# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ragel/ragel-5.19.ebuild,v 1.2 2007/03/22 22:29:32 twp Exp $

inherit eutils

DESCRIPTION="Compiles finite state machines from regular languages into executable code."
HOMEPAGE="http://www.cs.queensu.ca/~thurston/ragel/"
SRC_URI="http://www.cs.queensu.ca/~thurston/ragel/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc vim-syntax"
DEPEND="
	doc? (
		virtual/tetex
		media-gfx/transfig
	)"
RDEPEND=""

src_compile() {
	econf || die
	make || die
	( cd doc && make ragel.1 rlgen-{cd,java,ruby,dot}.1 ) || die
	if use doc; then
		( cd doc && make ragel-guide.pdf ) || die
	fi
}

src_install() {
	einstall || die
	for i in cd java ruby dot; do
		dobin rlgen-${i}/rlgen-${i}
	done
	doman doc/ragel.1 doc/rlgen-{cd,java,ruby,dot}.1
	dodoc ChangeLog CREDITS README TODO
	use doc && \
		install -m 644 -D doc/ragel-guide.pdf \
			"${D}/usr/share/doc/${PF}/ragel-guide.pdf"
	use vim-syntax && \
		install -m 644 -D ragel.vim \
			"${D}/usr/share/vim/vimfiles/syntax/ragel.vim"
}
