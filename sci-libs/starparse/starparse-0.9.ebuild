# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/starparse/starparse-0.9.ebuild,v 1.1 2009/01/13 06:24:14 dberkholz Exp $

if [[ ${PV} = 9999* ]]; then
	EBZR_REPO_URI="http://oregonstate.edu/~benisong/software/projects/starparse/"
	EBZR_BRANCH="releases/0.9"
	EBZR_BOOTSTRAP="eautoreconf"
	BZR="bzr"
fi

inherit autotools ${BZR}

DESCRIPTION="Library for parsing NMR star files (peak-list format) and CIF files"
HOMEPAGE="http://burrow-owl.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="guile"
RDEPEND="guile? ( dev-scheme/guile )"
DEPEND="${RDEPEND}"

src_compile() {
	econf $(use_enable guile) || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
