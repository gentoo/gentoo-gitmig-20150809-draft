# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tmux/tmux-1.5.ebuild,v 1.3 2011/08/26 09:37:36 chainsaw Exp $

EAPI=4

inherit eutils autotools

DESCRIPTION="Terminal multiplexer"
HOMEPAGE="http://tmux.sourceforge.net"
SRC_URI="mirror://sourceforge/tmux/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="vim-syntax"

DEPEND="
	|| ( >=dev-libs/libevent-2.0.10 <dev-libs/libevent-2 )
	sys-libs/ncurses"
RDEPEND="${DEPEND}
	vim-syntax? ( || (
			app-editors/vim
			app-editors/gvim ) )"

DOCS=( CHANGES FAQ NOTES TODO )

pkg_setup() {
	if has_version "<app-misc/tmux-1.3"; then
		echo
		ewarn "Commands 'up-pane', 'down-pane' and 'select-prompt' were removed in version 1.3."
		ewarn "You may want to update your configuration file accordingly to avoid errors on"
		ewarn "tmux startup."
		ewarn
		ewarn "For the full Changelog, together with details on what replaced the above"
		ewarn "commands, visit http://tmux.cvs.sourceforge.net/viewvc/tmux/tmux/CHANGES."
		ewarn
		ewarn "WARNING: after updating to ${P} you will _not_ be able to connect to any"
		ewarn "running 1.2 tmux server instances. You'll have to use an existing client to"
		ewarn "end your old sessions or kill the old server instances. Otherwise you'll have"
		ewarn "to temporarily downgrade to tmux 1.2 to access them."
		echo
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-darwin.patch  # drop on next release
	eautoreconf  # for darwin patch
	# look for config file in the prefix
	sed -i -e '/SYSTEM_CFG/s:"/etc:"'"${EPREFIX}"'/etc:' tmux.h || die
	# and don't just add some includes
	sed -i -e 's:-I/usr/local/include::' Makefile.in || die
}

src_install() {
	default

	docinto examples
	dodoc examples/*.conf

	if use vim-syntax; then
		insinto /usr/share/vim/vimfiles/syntax
		doins examples/tmux.vim

		insinto /usr/share/vim/vimfiles/ftdetect
		doins "${FILESDIR}"/tmux.vim
	fi
}
