# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wireless-regdb/wireless-regdb-20081117.ebuild,v 1.2 2008/12/02 11:46:37 armin76 Exp $

MY_P="wireless-regdb-master-${PV:0:4}-${PV:5:2}-${PV:6:2}"
DESCRIPTION="Binary regulatory database for CRDA"
HOMEPAGE="http://wireless.kernel.org/en/developers/Regulatory"
SRC_URI="http://wireless.kernel.org/download/wireless-regdb/${MY_P}.tar.bz2"
LICENSE="as-is"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="dev-libs/openssl
	dev-lang/python"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${MY_P}"

src_compile() {
	einfo "Recompiling regulatory.bin from db.txt would break CRDA verify. Installing untouched binary version."
}

src_install() {
	insinto /usr/lib/crda/
	doins regulatory.bin
}
