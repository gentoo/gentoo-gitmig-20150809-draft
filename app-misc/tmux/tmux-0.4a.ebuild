# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tmux/tmux-0.4a.ebuild,v 1.1 2008/07/30 18:01:53 swegener Exp $

inherit toolchain-funcs

DESCRIPTION="Simple, modern, alternative to programs such as GNU screen"
HOMEPAGE="http://tmux.sourceforge.net"
SRC_URI="mirror://sourceforge/tmux/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_compile() {
	emake DEBUG="" CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dobin tmux || die "dobin tmux failed"

	dodoc NOTES TODO
	docinto examples
	dodoc examples/*.conf

	doman tmux.1
}

pkg_postinst() {
	elog "NOTE that tmux doesn't support \\\033_string\\\033\\\\\\ for window"
	elog "titles. If you're using BASH unset PROMPT_COMMAND."
}
