# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/pwcrypt/pwcrypt-1.2.2.ebuild,v 1.12 2008/10/26 15:36:48 hattya Exp $

inherit toolchain-funcs

IUSE=""

DESCRIPTION="An improved version of cli-crypt (encrypts data sent to it from the cli)"
HOMEPAGE="http://xjack.org/pwcrypt/"
SRC_URI="http://xjack.org/pwcrypt/downloads/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"
SLOT="0"

src_compile() {

	tc-export CC
	econf || die
	emake || die

}

src_install() {

	dobin src/pwcrypt || die
	dodoc CREDITS README

}
