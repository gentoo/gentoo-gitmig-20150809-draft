# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/mathomatic/mathomatic-12.7.9.ebuild,v 1.2 2007/11/05 15:13:22 cryos Exp $

inherit eutils

DESCRIPTION="Automatic algebraic manipulator"
HOMEPAGE="http://www.mathomatic.com/"
SRC_URI="http://www.panix.com/~gesslein/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

DEPEND="sys-libs/readline
	sys-libs/ncurses"

src_compile() {
	emake READLINE=1 || die "emake failed"
}

src_install() {
	# It was easier just to install the files manually
	dobin mathomatic
	dodoc changes.txt README.txt
	doman mathomatic.1

	if use doc; then
		dohtml doc/*
		insinto /usr/share/doc/${PF}/examples
		doins tests/*.in
	fi
}
