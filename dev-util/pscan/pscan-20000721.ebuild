# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pscan/pscan-20000721.ebuild,v 1.4 2004/11/22 03:39:28 robbat2 Exp $

inherit toolchain-funcs

DESCRIPTION="A limited problem scanner for C source files"
HOMEPAGE="http://www.striker.ottawa.on.ca/~aland/pscan/"
# I wish upstream would version their files, even if it's only with a date
SRC_URI="http://www.striker.ottawa.on.ca/~aland/pscan/pscan.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	sys-devel/flex"

S="${WORKDIR}/${PN}"

src_compile() {
	emake CC="$(tc-getCC) ${CFLAGS}" || die
}

src_install() {
	dobin pscan || die
	dodoc README find_formats.sh test.c wu-ftpd.pscan
}
