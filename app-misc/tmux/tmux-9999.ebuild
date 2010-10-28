# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tmux/tmux-9999.ebuild,v 1.1 2010/10/28 20:55:42 wired Exp $

EAPI=3

ECVS_SERVER="tmux.cvs.sourceforge.net:/cvsroot/tmux"
ECVS_MODULE="tmux"

inherit cvs toolchain-funcs

DESCRIPTION="Terminal multiplexer"
HOMEPAGE="http://tmux.sourceforge.net"
SRC_URI=""

LICENSE="ISC"
SLOT="0"
KEYWORDS=""
IUSE="vim-syntax"

DEPEND="<dev-libs/libevent-2
	sys-libs/ncurses"
RDEPEND="${DEPEND}
	vim-syntax? ( || (
			app-editors/vim
			app-editors/gvim ) )"

S="${WORKDIR}"/"${PN}"

src_configure() {
	# The configure script isn't created by GNU autotools.
	./configure || die "configure failed"
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dobin tmux || die "dobin failed"

	dodoc CHANGES FAQ NOTES TODO || die "dodoc failed"
	docinto examples
	dodoc examples/*.conf || die "dodoc examples failed"

	doman tmux.1 || die "doman failed"

	if use vim-syntax; then
		insinto /usr/share/vim/vimfiles/syntax
		doins examples/tmux.vim || die "doins syntax failed"

		insinto /usr/share/vim/vimfiles/ftdetect
		doins "${FILESDIR}"/tmux.vim || die "doins ftdetect failed"
	fi
}
