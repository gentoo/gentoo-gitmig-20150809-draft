# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/acctail/acctail-1.3.ebuild,v 1.1 2005/03/03 15:18:38 ciaranm Exp $

inherit eutils toolchain-funcs
DESCRIPTION="shows all processes as they exit, along with the accounting information"
HOMEPAGE="http://www.vanheusden.com/acctail/"
SRC_URI="${HOMEPAGE}${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/libc
		sys-apps/acct"

src_compile() {
	tc-export CC LD AR
	emake CC="${CC}" LD="${LD}" AR="${AR}" CFLAGS="${CFLAGS:--Wall}" || die
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
}
