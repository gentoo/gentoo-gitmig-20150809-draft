# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pscan/pscan-20000721.ebuild,v 1.6 2005/08/12 20:33:44 metalgod Exp $

inherit toolchain-funcs

DESCRIPTION="A limited problem scanner for C source files"
HOMEPAGE="http://www.striker.ottawa.on.ca/~aland/pscan/"
# I wish upstream would version their files, even if it's only with a date
SRC_URI="http://www.striker.ottawa.on.ca/~aland/pscan/pscan.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
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
