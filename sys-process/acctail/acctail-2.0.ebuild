# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/acctail/acctail-2.0.ebuild,v 1.2 2007/10/27 23:06:23 ticho Exp $

inherit eutils toolchain-funcs
DESCRIPTION="shows all processes as they exit, along with the accounting information"
HOMEPAGE="http://www.vanheusden.com/acctail/"
SRC_URI="${HOMEPAGE}${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""
DEPEND="virtual/libc
		sys-process/acct"

src_unpack() {
	unpack ${A}
	sed -i '/^CPPFLAGS+=/s:-O2::' "${S}"/Makefile || die "sed Makefile failed"
}

src_compile() {
	tc-export CC LD AR
	emake CC="${CC}" LD="${LD}" AR="${AR}" CFLAGS="${CFLAGS} -Wall" || die
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
}
