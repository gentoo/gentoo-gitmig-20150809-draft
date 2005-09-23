# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/mathomatic/mathomatic-12.4.11.ebuild,v 1.1 2005/09/23 00:43:20 cryos Exp $

inherit eutils

DESCRIPTION="Automatic algebraic manipulator"
HOMEPAGE="http://www.mathomatic.com/"
SRC_URI="http://www.panix.com/~gesslein/${P}.tgz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc icc"

DEPEND="sys-libs/readline
	sys-libs/ncurses
	icc? ( dev-lang/icc )"

src_compile() {
	if use icc; then
		CC="icc" CFLAGS="-O3 -axKWNBP -ipo" LDFLAGS="-O3 -axKWNBP -ipo -limf" emake || die "emake failed"
	else
		emake || die "emake failed"
	fi
}

src_install() {
	# It was easier just to install the files manually
	dobin mathomatic
	dodoc changes.txt README.txt
	doman doc/mathomatic.1

	if use doc; then
		dohtml doc/*
		insinto /usr/share/doc/${PF}/examples
		doins tests/*.in
	fi
}
