# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/scanmem/scanmem-0.05.ebuild,v 1.1 2007/03/06 12:59:19 taviso Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Locate and modify variables in executing processes"
HOMEPAGE="http://taviso.decsystem.org/scanmem.html/"
SRC_URI="http://taviso.decsystem.org/files/scanmem//${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="sys-libs/readline"
RDEPEND="${DEPEND}"

src_compile() {
	emake CFLAGS="${CFLAGS}" CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dobin scanmem
	doman scanmem.1
	dodoc README TODO ChangeLog
}
