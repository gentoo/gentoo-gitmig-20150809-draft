# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/chntpw/chntpw-0.99.3.20040818.ebuild,v 1.6 2005/04/09 22:17:33 vanquirius Exp $

inherit eutils

DESCRIPTION="Offline Windows NT Password & Registry Editor"
HOMEPAGE="http://home.eunet.no/~pnordahl/ntpasswd/"
MY_PV="${PV/*200/0}"
LICENSE="chntpw"
SLOT="0"
KEYWORDS="~x86 ~ppc"
DEPEND="dev-libs/openssl
	app-arch/unzip"
SRC_URI="http://home.eunet.no/~pnordahl/ntpasswd/chntpw-source-${MY_PV}.zip"
IUSE=""
S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gcc4.diff
}

src_compile() {
	emake LIBS="-lcrypto" CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	into /usr
	dobin chntpw
	dodoc *.txt
}
