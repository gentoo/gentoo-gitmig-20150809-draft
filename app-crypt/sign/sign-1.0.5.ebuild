# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/sign/sign-1.0.5.ebuild,v 1.2 2004/07/17 10:12:30 dholm Exp $

DESCRIPTION="File signing and signature verification utility"
HOMEPAGE="http://swapped.cc/sign/"
SRC_URI="http://swapped.cc/${PN}/files/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=">=dev-libs/openssl-0.9.6"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin sign || die "dobin failed"
	doman man/sign.1 || die "doman failed"
	dodoc README || die "dodoc failed"
}
