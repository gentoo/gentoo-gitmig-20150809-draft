# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/chntpw/chntpw-0.99.4.20070923.ebuild,v 1.1 2007/09/28 18:57:54 alonbl Exp $

DESCRIPTION="Offline Windows NT Password & Registry Editor"
HOMEPAGE="http://home.eunet.no/~pnordahl/ntpasswd/"
MY_PV="${PV/*200/0}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
DEPEND="dev-libs/openssl"
RDEPEND="${DEPEND}"
SRC_URI="http://home.eunet.no/~pnordahl/ntpasswd/${PN}-source-${MY_PV}.zip"
IUSE="static"
S="${WORKDIR}/${PN}-${MY_PV}"

src_compile() {
	emake LIBS="-lcrypto" CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin chntpw
	use static && dobin chntpw.static
	dobin cpnt
	dodoc *.txt
}
