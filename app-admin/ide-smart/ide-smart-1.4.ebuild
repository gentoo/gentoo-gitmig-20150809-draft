# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/ide-smart/ide-smart-1.4.ebuild,v 1.20 2004/06/25 17:39:58 vapier Exp $

inherit gcc

DESCRIPTION="A tool to read SMART information from harddiscs"
HOMEPAGE="http://lightside.eresmas.com/"
SRC_URI="http://lightside.eresmas.com/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	emake \
		CC="$(gcc-getCC)" PROF="${CFLAGS}" \
		clean all || die
}

src_install() {
	dobin ide-smart || die
	doman ide-smart.8
	dodoc README
}
