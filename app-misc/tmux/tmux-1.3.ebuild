# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tmux/tmux-1.3.ebuild,v 1.9 2011/07/02 20:00:20 nixnut Exp $

EAPI=3

inherit toolchain-funcs

DESCRIPTION="Terminal multiplexer"
HOMEPAGE="http://tmux.sourceforge.net"
SRC_URI="mirror://sourceforge/tmux/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="vim-syntax"

DEPEND="
	<dev-libs/libevent-2
	sys-libs/ncurses"
RDEPEND="${DEPEND}
	vim-syntax? ( || (
			app-editors/vim
			app-editors/gvim ) )"

pkg_setup() {
	echo
	ewarn "Commands 'up-pane', 'down-pane' and 'select-prompt' were removed in version 1.3."
	ewarn "You may want to update your configuration file accordingly to avoid errors on"
	ewarn "tmux startup."
	ewarn
	ewarn "For the full 1.3 Changelog, together with details on what replaced the above"
	ewarn "commands, visit http://tmux.cvs.sourceforge.net/viewvc/tmux/tmux/CHANGES."
	ewarn
	ewarn "WARNING: after updating to tmux 1.3 you will _not_ be able to connect to any"
	ewarn "running 1.2 tmux server instances. You'll have to use an existing client to"
	ewarn "end your old sessions or kill the old server instances. Otherwise you'll have"
	ewarn "to temporarily downgrade to tmux 1.2 to access them."
	echo
}

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
