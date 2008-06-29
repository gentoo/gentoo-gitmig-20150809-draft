# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/chntpw/chntpw-080526.ebuild,v 1.1 2008/06/29 03:17:18 darkside Exp $

DESCRIPTION="Offline Windows NT Password & Registry Editor"
HOMEPAGE="http://home.eunet.no/~pnordahl/ntpasswd/"
SRC_URI="http://home.eunet.no/~pnordahl/ntpasswd/${PN}-source-${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="static"

RDEPEND="dev-libs/openssl"
DEPEND="app-arch/unzip"

src_compile() {
	#Makefile is hardcoded, override the defaults with the user's settings.
	emake LIBS="-lcrypto" CFLAGS="${CFLAGS}" || die "emake failed" 
}

src_install() {
	dobin chntpw
	use static && dobin chntpw.static
	dobin cpnt
	dodoc *.txt
}
