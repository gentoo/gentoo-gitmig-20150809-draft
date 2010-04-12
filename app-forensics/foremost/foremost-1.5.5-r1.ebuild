# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/foremost/foremost-1.5.5-r1.ebuild,v 1.1 2010/04/12 20:20:14 idl0r Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A console program to recover files based on their headers and footers"
HOMEPAGE="http://foremost.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

KEYWORDS="~ppc ~x86 ~amd64"
IUSE=""
LICENSE="public-domain"
SLOT="0"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-1.4-config-location.patch"
}

src_compile() {
	emake RAW_FLAGS="${CFLAGS} -Wall" RAW_CC="$(tc-getCC) -DVERSION=\\\"${PV}\\\"" \
		CONF=/etc || die "emake failed"
}

src_install() {
	dobin foremost || die
	doman foremost.8.gz
	insinto /etc
	doins foremost.conf
	dodoc README CHANGES
}
