# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nessus-libraries/nessus-libraries-2.2.0.ebuild,v 1.5 2005/03/27 03:35:45 weeve Exp $

DESCRIPTION="A remote security scanner for Linux (nessus-libraries)"
HOMEPAGE="http://www.nessus.org/"
SRC_URI="ftp://ftp.nessus.org/pub/nessus/nessus-${PV}/src/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc ~alpha ~amd64 ~ppc64"
IUSE=""

# Hard dep on SSL since libnasl won't compile when this package is emerged -ssl.
DEPEND=">=dev-libs/openssl-0.9.6d"
S=${WORKDIR}/${PN}

src_compile() {
	local myconf=""
	myconf="--with-ssl=/usr/lib"

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall
	dodoc README*
}
