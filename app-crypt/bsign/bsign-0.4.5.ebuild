# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/bsign/bsign-0.4.5.ebuild,v 1.2 2004/04/15 19:56:07 dholm Exp $

DESCRIPTION="This package embeds secure hashes (SHA1) and digital signatures (GNU Privacy Guard) into files for verification and authentication"
HOMEPAGE="http://packages.debian.org/unstable/admin/bsign.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/b/bsign/${PN}_${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND=""
RDEPEND=""

S=${WORKDIR}/${P}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die "emake failed"
}

src_install() {
	dobin bsign
	dobin bsign_sign
	dobin bsign_verify
	dobin bsign_hash
	dobin bsign_check
	doman bsign.1
}
