# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/egads/egads-0.9.5.ebuild,v 1.2 2004/06/07 05:55:02 dragonheart Exp $

DESCRIPTION="EGADS - Entropy Gathering And Distribution System"
HOMEPAGE="http://www.securesoftware.com/download_${PN}.htm"
SRC_URI="http://www.securesoftware.com/${PN}/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
IUSE=""
KEYWORDS="x86"
DEPEND="virtual/glibc"

egadsdatadir=/var/run/egads

src_compile() {
	econf --with-egads-datadir="${egadsdatadir}" --with-bindir=/usr/sbin || die
	emake || die


}

src_install () {
	keepdir ${egadsdatadir}
	fperm +t ${egadsdatadir}
	einstall BINDIR=${D}/usr/sbin || die
	dodoc README* doc/*.txt
	dohtml doc/*.html
}

