# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/egads/egads-0.9.5.ebuild,v 1.5 2005/01/01 14:59:56 eradicator Exp $

DESCRIPTION="Entropy Gathering And Distribution System"
HOMEPAGE="http://www.securesoftware.com/download_${PN}.htm"
SRC_URI="http://www.securesoftware.com/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/libc"

egadsdatadir=/var/run/egads

src_compile() {
	econf --with-egads-datadir="${egadsdatadir}" --with-bindir=/usr/sbin || die
	emake || die
}

src_install() {
	keepdir ${egadsdatadir}
	fperm +t ${egadsdatadir}
	einstall BINDIR=${D}/usr/sbin || die
	dodoc README* doc/*.txt
	dohtml doc/*.html
}
