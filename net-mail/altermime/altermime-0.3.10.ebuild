# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/altermime/altermime-0.3.10.ebuild,v 1.2 2010/06/06 01:14:18 ssuominen Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION=" alterMIME is a small program which is used to alter your mime-encoded mailpacks"
SRC_URI="http://www.pldaniels.com/altermime/${P}.tar.gz"
HOMEPAGE="http://pldaniels.com/altermime/"

LICENSE="Sendmail"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~s390 ~x86"
IUSE=""

src_prepare() {
	sed -i \
		-e "/^CFLAGS[[:space:]]*=/ s/-O2/${CFLAGS}/" \
		-e 's/${CFLAGS} altermime.c/${CFLAGS} ${LDFLAGS} altermime.c/' \
		Makefile || die

	epatch "${FILESDIR}"/${P}-fprintf-fixes.patch \
		"${FILESDIR}"/${P}-MIME_headers-overflow.patch
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install () {
	dobin altermime || die
	dodoc CHANGELOG README || die
}
