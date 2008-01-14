# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hbaapi/hbaapi-2.2.ebuild,v 1.2 2008/01/14 02:24:11 robbat2 Exp $

DESCRIPTION="The Host Bus Adapter API for managing Fibre Channel Host Bus Adapters"
HOMEPAGE="http://hbaapi.sourceforge.net/"
MY_PN="${PN}_src"
MY_P="${MY_PN}_${PV}"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tgz
		 mirror://gentoo/${P}.Makefile.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~ppc ~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}"/${P}.Makefile "${S}"/Makefile
}

src_compile() {
	# not parallel safe!
	emake -j1 all
}

src_install() {
	into /usr
	dolib.so libHBAAPI.so
	dosbin hbaapitest
	insinto /etc
	doins "${FILESDIR}"/hba.conf
	dodoc readme.txt
}
