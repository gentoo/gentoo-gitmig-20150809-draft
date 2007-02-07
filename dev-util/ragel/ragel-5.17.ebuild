# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ragel/ragel-5.17.ebuild,v 1.1 2007/02/07 12:49:40 twp Exp $

inherit eutils

DESCRIPTION="This is a sample skeleton ebuild file"
HOMEPAGE="http://www.cs.queensu.ca/~thurston/ragel/"
SRC_URI="http://www.cs.queensu.ca/~thurston/ragel/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc vim-syntax"
DEPEND="
	doc? (
		app-text/tetex
		media-gfx/transfig
	)"
RDEPEND=""

src_compile() {
	econf || die
	emake || die
	( cd doc && make ragel.1 rlcodegen.1 ) || die
	use doc && ( cd doc && make ragel-guide.pdf ) || die
}

src_install() {
	dobin ragel/ragel rlcodegen/rlcodegen
	doman doc/ragel.1 doc/rlcodegen.1
	dodoc ChangeLog CREDITS README TODO
	use doc && \
		install -m 644 -D doc/ragel-guide.pdf \
			${D}/usr/share/doc/${PF}/ragel-guide.pdf
	use vim-syntax && \
		install -m 644 -D ragel.vim \
			${D}/usr/share/vim/vimfiles/syntax/ragel.vim
}
