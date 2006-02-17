# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/unrtf/unrtf-0.19.9.ebuild,v 1.1 2006/02/17 01:35:00 robbat2 Exp $

inherit eutils

DESCRIPTION="Converts RTF files to various formats"
HOMEPAGE="http://www.gnu.org/software/unrtf/unrtf.html"
#SRC_URI="mirror://gentoo/${P}.tar.gz"
MY_P="${P/-/_}"
SRC_URI="http://www.gnu.org/software/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~s390 ~x86 ~sparc"
IUSE=""

DEPEND="virtual/libc"
S="${WORKDIR}/${MY_P}"

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin unrtf || die
	doman unrtf.1
	dohtml doc/unrtf.html
	dodoc CHANGES README TODO
}
