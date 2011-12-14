# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ssmping/ssmping-0.9-r1.ebuild,v 1.7 2011/12/14 23:15:55 ago Exp $

inherit toolchain-funcs eutils

DESCRIPTION="Tool for testing multicast connectivity"
HOMEPAGE="http://www.venaas.no/multicast/ssmping/"
SRC_URI="http://www.venaas.no/multicast/ssmping/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch #240750
	tc-export CC
}

src_install() {
	dobin ssmping asmping mcfirst || die
	dosbin ssmpingd || die
	doman ssmping.1 asmping.1 mcfirst.1
}
