# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nessus-libraries/nessus-libraries-2.2.9.ebuild,v 1.1 2007/04/03 14:32:53 vanquirius Exp $

inherit toolchain-funcs

DESCRIPTION="A remote security scanner for Linux (nessus-libraries)"
HOMEPAGE="http://www.nessus.org/"
SRC_URI="ftp://ftp.nessus.org/pub/nessus/nessus-${PV}/src/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

# Hard dep on SSL since libnasl won't compile when this package is emerged -ssl.
DEPEND=">=dev-libs/openssl-0.9.6d"
S="${WORKDIR}/${PN}"

src_compile() {
	export CC="$(tc-getCC)"
	econf --with-ssl=/usr/lib || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "failed to install"
	dodoc README*
}
