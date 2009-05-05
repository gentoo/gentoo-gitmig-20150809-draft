# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/flashrom/flashrom-0.9.0.ebuild,v 1.1 2009/05/05 22:46:55 leio Exp $

EAPI=2

inherit eutils toolchain-funcs

DESCRIPTION="Utility for reading, writing, erasing and verifying flash ROM chips."
HOMEPAGE="http://www.coreboot.org/Flashrom/"
SRC_URI="http://qa.coreboot.org/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-apps/pciutils"
DEPEND="${RDEPEND}
	sys-apps/sed"

src_prepare()
{
	sed -i -e '/STRIP/d' \
		-e "s:-Os -Wall -Werror:-Wall ${CFLAGS}:" \
		-e "s:LDFLAGS = :LDFLAGS = ${LDFLAGS}:" "${S}/Makefile" || die "sed failed"
}

src_compile()
{
	emake -j1 CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dosbin flashrom
	doman flashrom.8
	dodoc README
}
