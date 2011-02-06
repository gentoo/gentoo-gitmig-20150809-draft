# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/rpl/rpl-1.4.0.ebuild,v 1.26 2011/02/06 07:38:28 leio Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Intelligent recursive search/replace utility"
HOMEPAGE="http://rpl.sourceforge.net/"
SRC_URI="http://downloads.laffeycomputer.com/current_builds/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc4.patch
}

src_compile() {
	tc-export CC
	econf
	emake || die
}

src_install () {
	dobin src/rpl || die
	doman man/rpl.1 || die
	dodoc AUTHORS ChangeLog NEWS README || die
}
