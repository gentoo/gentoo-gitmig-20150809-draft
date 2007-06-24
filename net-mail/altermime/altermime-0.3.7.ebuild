# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/altermime/altermime-0.3.7.ebuild,v 1.3 2007/06/24 23:15:44 vapier Exp $

inherit toolchain-funcs

DESCRIPTION=" alterMIME is a small program which is used to alter your mime-encoded mailpacks"
SRC_URI="http://www.pldaniels.com/altermime/${P}.tar.gz"
HOMEPAGE="http://pldaniels.com/altermime/"

LICENSE="Sendmail"
KEYWORDS="~amd64 ~ppc s390 x86"
IUSE=""
SLOT="0"

src_unpack() {
	unpack ${A}
	sed -i -e "/^CFLAGS[[:space:]]*=/ s/-O2/${CFLAGS}/" \
		-e 's/${CFLAGS} altermime.c/${CFLAGS} ${LDFLAGS} altermime.c/' \
		"${S}"/Makefile || die "sed failed."
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed."
}

src_install () {
	dobin altermime || die "dobin failed."
	dodoc CHANGELOG LICENCE README || die "dodoc failed."
}
