# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/rblcheck/rblcheck-1.5.ebuild,v 1.9 2010/10/19 05:55:35 leio Exp $

inherit eutils

DESCRIPTION="Perform lookups in RBL-styles services."
HOMEPAGE="http://rblcheck.sourceforge.net/"
SRC_URI="mirror://sourceforge/rblcheck/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha ~amd64 hppa ~mips ppc sparc x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-configure.patch"
}

src_install () {
	exeinto /usr/bin
	doexe rbl rblcheck

	dodoc README docs/rblcheck.ps docs/rblcheck.rtf
}
