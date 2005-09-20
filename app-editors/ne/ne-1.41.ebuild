# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/ne/ne-1.41.ebuild,v 1.2 2005/09/20 18:46:17 kito Exp $

inherit toolchain-funcs

DESCRIPTION="the nice editor, easy to use for the beginner and powerful for the wizard"
HOMEPAGE="http://ne.dsi.unimi.it/"
SRC_URI="http://ne.dsi.unimi.it/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc-macos ~ppc64 ~x86"
IUSE=""

RDEPEND=">=sys-libs/ncurses-5.2"
DEPEND="${RDEPEND}
	dev-lang/perl"

PROVIDE="virtual/editor"

src_compile() {
	emake -j1 -C src ne OPTS="${CFLAGS}" CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dobin src/ne || die "dobin failed"
	doman doc/ne.1 || die "doman failed"
	dohtml doc/*.html || die "dohtml failed"
	dodoc CHANGES README doc/*.{txt,ps,pdf,texinfo} doc/default.* || die "dodoc failed"
}
