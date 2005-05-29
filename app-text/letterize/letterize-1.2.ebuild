# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/letterize/letterize-1.2.ebuild,v 1.1 2005/05/29 19:33:54 usata Exp $

DESCRIPTION="Generate English-plausible alphabetic mnemonics for a phone number"
HOMEPAGE="http://www.catb.org/~esr/letterize/"
SRC_URI="http://www.catb.org/~esr/letterize/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_install() {
	dobin letterize || die "dobin error"
	doman letterize.1 || die "doman error"
	dodoc README || die "dodoc error"
}
