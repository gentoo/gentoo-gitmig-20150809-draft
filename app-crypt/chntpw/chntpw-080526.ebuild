# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/chntpw/chntpw-080526.ebuild,v 1.4 2009/10/28 04:18:27 robbat2 Exp $

inherit toolchain-funcs

DESCRIPTION="Offline Windows NT Password & Registry Editor"
HOMEPAGE="http://home.eunet.no/~pnordahl/ntpasswd/"
SRC_URI="http://home.eunet.no/~pnordahl/ntpasswd/${PN}-source-${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="static"

RDEPEND="dev-libs/openssl"
DEPEND="app-arch/unzip"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e "/^CC/s/gcc/$(tc-getCC)/" \
		Makefile || die "sed failed"
}

src_compile() {
	#Makefile is hardcoded, override the defaults with the user's settings.
	emake LIBS="-lcrypto" CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin chntpw
	use static && dobin chntpw.static
	dobin cpnt
	dodoc HISTORY.txt README.txt regedit.txt WinReg.txt
}
