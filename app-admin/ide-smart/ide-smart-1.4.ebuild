# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/ide-smart/ide-smart-1.4.ebuild,v 1.23 2004/11/06 04:13:48 mr_bones_ Exp $

inherit toolchain-funcs

DESCRIPTION="A tool to read SMART information from harddiscs"
HOMEPAGE="http://www.linalco.com/comunidad.html"
SRC_URI="http://www.linalco.com/ragnar/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	emake -j1 \
		CC="$(tc-getCC)" PROF="${CFLAGS}" \
		clean all || die
}

src_install() {
	dobin ide-smart || die
	doman ide-smart.8
	dodoc README
}
