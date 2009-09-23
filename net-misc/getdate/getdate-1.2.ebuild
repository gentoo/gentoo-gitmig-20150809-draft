# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/getdate/getdate-1.2.ebuild,v 1.11 2009/09/23 19:35:47 patrick Exp $

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

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	#remove prestripped binary as per bug #240934
	sed -i -e "s:install -s:install:" Makefile
}

src_compile() {
	$(tc-getCC) ${CFLAGS} -DHAVE_ADJTIME -o getdate getdate.c || die
}

src_install() {
	dobin getdate || die "dobin failed"
	doman getdate.8
	dodoc README getdate-cron
}
