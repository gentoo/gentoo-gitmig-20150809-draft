# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pscan/pscan-20000721.ebuild,v 1.2 2004/10/17 10:00:21 dholm Exp $

DESCRIPTION="PScan: A limited problem scanner for C source files"
HOMEPAGE="http://www.striker.ottawa.on.ca/~aland/pscan/"
# I wish upstream would version their files, even if it's only with a date
SRC_URI="http://www.striker.ottawa.on.ca/~aland/pscan/pscan.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
RDEPEND="virtual/libc"
DEPEND="${RDEPEND} sys-devel/gcc sys-devel/flex"
S="${WORKDIR}/${PN}"

src_compile() {
	emake CC="gcc ${CFLAGS}"
}

src_install() {
	into /usr
	dobin pscan
	dodoc COPYING README find_formats.sh test.c wu-ftpd.pscan
}
