# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/bsign/bsign-0.4.5.ebuild,v 1.6 2004/06/24 21:30:26 agriffis Exp $

DESCRIPTION="embed secure hashes (SHA1) and digital signatures (GNU Privacy Guard) into files"
HOMEPAGE="http://packages.debian.org/unstable/admin/bsign.html"
SRC_URI="mirror://debian/pool/main/b/bsign/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	dobin bsign bsign_sign bsign_verify bsign_hash bsign_check || die
	doman bsign.1
}
