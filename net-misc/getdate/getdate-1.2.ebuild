# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/getdate/getdate-1.2.ebuild,v 1.9 2005/07/30 17:57:36 swegener Exp $

inherit toolchain-funcs

MY_PN=${PN}_rfc868
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}

IUSE=""
DESCRIPTION="Network Date/Time Query and Set Local Date/Time Utility"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/system/network/misc/"
SRC_URI="http://www.ibiblio.org/pub/Linux/system/network/misc/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~mips ppc"

DEPEND="virtual/libc"
RDEPEND="${DEPEND}"

src_compile() {
	$(tc-getCC) ${CFLAGS} -DHAVE_ADJTIME -s -o getdate getdate.c || die
}

src_install() {
	dobin getdate
	doman getdate.8
	dodoc README getdate-cron
}
