# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/dinero/dinero-4.7.ebuild,v 1.6 2004/06/24 22:30:37 agriffis Exp $

MY_P="d${PV/./-}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Cache simulator"
HOMEPAGE="http://www.cs.wisc.edu/~markhill/DineroIV/"
SRC_URI="ftp://ftp.cs.wisc.edu/markhill/DineroIV/${MY_P}.tar.gz"

SLOT="0"
KEYWORDS="x86 ~ppc"
LICENSE="as-is"
IUSE=""

src_install() {
	dobin dineroIV || die "dobin failed"
	dodoc CHANGES COPYRIGHT NOTES README TODO || die "dodoc failed"
}
