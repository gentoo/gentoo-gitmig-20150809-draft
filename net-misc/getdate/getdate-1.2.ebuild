# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/getdate/getdate-1.2.ebuild,v 1.6 2005/02/13 03:39:43 robbat2 Exp $

MY_PN=${PN}_rfc868
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}

IUSE=""
DESCRIPTION="Network Date/Time Query and Set Local Date/Time Utility"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/system/network/misc/"
SRC_URI="http://www.ibiblio.org/pub/Linux/system/network/misc/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~mips"

DEPEND="virtual/libc"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
}

src_compile() {
	gcc ${CFLAGS} -DHAVE_ADJTIME -s -o getdate getdate.c || die
}

src_install() {
	doman getdate.8
	dobin getdate
	dodoc README getdate-cron
}

