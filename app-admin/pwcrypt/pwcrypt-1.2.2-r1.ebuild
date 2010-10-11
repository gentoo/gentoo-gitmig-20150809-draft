# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/pwcrypt/pwcrypt-1.2.2-r1.ebuild,v 1.1 2010/10/11 09:30:35 hattya Exp $

EAPI="3"

inherit toolchain-funcs

IUSE=""

DESCRIPTION="An improved version of cli-crypt (encrypts data sent to it from the cli)"
HOMEPAGE="http://xjack.org/pwcrypt/"
SRC_URI="http://xjack.org/pwcrypt/downloads/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"

src_prepare()  {

	sed -i "s/make\( \|$\)/\$(MAKE)\1/g" Makefile.in || die

	sed -i \
		-e "/^LDFLAGS/s/= /= @LDFLAGS@ /" \
		-e "/-install/s/ -s//" \
		src/Makefile.in \
		|| die

	tc-export CC

}

src_install() {

	emake DESTDIR="${D}" install || die
	dodoc CREDITS README

}
