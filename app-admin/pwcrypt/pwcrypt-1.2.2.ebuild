# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/pwcrypt/pwcrypt-1.2.2.ebuild,v 1.8 2005/01/01 11:20:57 eradicator Exp $

DESCRIPTION="An improved version of cli-crypt (encrypts data sent to it from the cli)"
HOMEPAGE="http://xjack.org/pwcrypt"
SRC_URI="http://xjack.org/pwcrypt/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="virtual/libc"

src_install() {
	dobin src/pwcrypt || die
	dodoc [A-Z][A-Z]*
}
