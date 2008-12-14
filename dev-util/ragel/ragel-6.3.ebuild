# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ragel/ragel-6.3.ebuild,v 1.5 2008/12/14 16:02:25 aballier Exp $

EAPI=2

inherit eutils

DESCRIPTION="Compiles finite state machines from regular languages into executable code."
HOMEPAGE="http://www.complang.org/ragel/"
SRC_URI="http://www.complang.org/ragel/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc vim-syntax"

DEPEND="
	doc? (
		|| (
			( app-text/texlive-core dev-texlive/texlive-latexextra )
			app-text/tetex
		)
		media-gfx/transfig
	)"
RDEPEND=""

src_prepare() {
	find "${S}" -iname "Makefile*" -exec sed -i \
		-e "s:install -s:install:" \
		-e '/\$(CXX)/s:CFLAGS:CXXFLAGS:' \
		{} \;
}

src_compile() {
	emake || die

	pushd doc
	emake ragel.1 rlgen-{cd,java,ruby,dot}.1 || die
	popd

	if use doc ; then
		pushd doc
		emake ragel-guide.pdf || die
		popd
	fi
}

src_install() {
	einstall || die

	for i in cd java ruby dot; do
		dobin rlgen-${i}/rlgen-${i}
	done
	doman doc/ragel.1 doc/rlgen-{cd,java,ruby,dot}.1
	dodoc ChangeLog CREDITS README TODO

	if use doc; then
		insinto /usr/share/doc/"${PF}"
		doins doc/ragel-guide.pdf
	fi

	if use vim-syntax; then
		insinto /usr/share/vim/vimfiles/syntax
		doins ragel.vim
	fi
}
