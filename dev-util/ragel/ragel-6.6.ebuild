# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ragel/ragel-6.6.ebuild,v 1.10 2010/08/05 17:03:28 maekke Exp $

DESCRIPTION="Compiles finite state machines from regular languages into executable code."
HOMEPAGE="http://www.complang.org/ragel/"
SRC_URI="http://www.complang.org/ragel/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="vim-syntax"

DEPEND=""
RDEPEND=""

# We need to get the txl language in Portage to have the tests :(
RESTRICT=test

src_compile() {
	econf --docdir=/usr/share/doc/${PF} || die "econf failed"
	emake || die "emake failed"
}

src_test() {
	cd "${S}"/test
	./runtests.in || die
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog CREDITS README TODO || die "dodoc failed"

	if use vim-syntax; then
		insinto /usr/share/vim/vimfiles/syntax
		doins ragel.vim || die "doins ragel.vim failed"
	fi
}
