# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tmux/tmux-1.2.ebuild,v 1.9 2010/07/02 12:22:11 grobian Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Terminal multiplexer"
HOMEPAGE="http://tmux.sourceforge.net"
SRC_URI="mirror://sourceforge/tmux/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="vim-syntax"

DEPEND="dev-libs/libevent
	sys-libs/ncurses"
RDEPEND="${DEPEND}
	vim-syntax? ( || (
			app-editors/vim
			app-editors/gvim ) )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-locale.patch
}

src_compile() {
	# The configure script isn't created by GNU autotools.
	./configure || die "configure failed"
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

pkg_preinst() {
	has_version "<${CATEGORY}/${PN}-1.1"
	PREVIOUS_LESS_THAN_1_1=$?
}

pkg_postinst() {
	if [[ ${PREVIOUS_LESS_THAN_1_1} -eq 0 ]]; then
		ewarn "The 1.1 release replaced the internal locking mechanism"
		ewarn "by executing a shell command (such as app-misc/vlock),"
		ewarn "thus the set-password command, and the -U command line"
		ewarn "flag were removed, as well as -d, since tmux will now"
		ewarn "automatically detect default colours."
	fi
}
