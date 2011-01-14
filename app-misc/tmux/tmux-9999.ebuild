# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tmux/tmux-9999.ebuild,v 1.3 2011/01/14 09:07:58 wired Exp $

EAPI=3

ECVS_SERVER="tmux.cvs.sourceforge.net:/cvsroot/tmux"
ECVS_MODULE="tmux"

inherit autotools cvs

DESCRIPTION="Terminal multiplexer"
HOMEPAGE="http://tmux.sourceforge.net"
SRC_URI=""

LICENSE="ISC"
SLOT="0"
KEYWORDS=""
IUSE="debug vim-syntax"

DEPEND="
	|| ( >=dev-libs/libevent-2.0.10 <dev-libs/libevent-2 )
	sys-libs/ncurses"
RDEPEND="${DEPEND}
	vim-syntax? ( || (
			app-editors/vim
			app-editors/gvim ) )"

S="${WORKDIR}"/${PN}

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable debug)
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc CHANGES FAQ NOTES TODO || die "dodoc failed"
	docinto examples
	dodoc examples/*.conf || die "dodoc examples failed"

	if use vim-syntax; then
		insinto /usr/share/vim/vimfiles/syntax
		doins examples/tmux.vim || die "doins syntax failed"

		insinto /usr/share/vim/vimfiles/ftdetect
		doins "${FILESDIR}"/tmux.vim || die "doins ftdetect failed"
	fi
}
