# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tmux/tmux-0.4a.ebuild,v 1.3 2008/10/24 21:17:59 pvdabeel Exp $

inherit toolchain-funcs

DESCRIPTION="Terminal multiplexer"
HOMEPAGE="http://tmux.sourceforge.net"
SRC_URI="mirror://sourceforge/tmux/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_compile() {
	emake DEBUG="" CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dobin tmux || die "dobin failed"

	dodoc NOTES TODO || die "dodoc failed"
	docinto examples
	dodoc examples/*.conf || die "dodoc examples failed"

	doman tmux.1 || die "doman failed"
}

pkg_postinst() {
	elog "NOTE that tmux doesn't support \\\033_string\\\033\\\\\\ for window"
	elog "titles. If you're using BASH unset PROMPT_COMMAND."
}
