# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/openbsc/openbsc-9999.ebuild,v 1.1 2014/04/26 02:39:45 zx2c4 Exp $

EAPI=5

inherit autotools git-2

DESCRIPTION="OpenBSC, OsmoSGSN, OsmoBSC and other programs"
HOMEPAGE="http://openbsc.osmocom.org/trac/wiki/OpenBSC"
#SRC_URI="http://cgit.osmocom.org/cgit/${PN}/snapshot/${P}.tar.bz2"
EGIT_REPO_URI="git://git.osmocom.org/${PN}.git"
#EGIT_BRANCH="jolly/testing"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="net-libs/libosmocore net-libs/libosmo-abis"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}/${PN}"
EGIT_SOURCEDIR="${WORKDIR}/${P}"

src_prepare() {
	#sed -i "s/UNKNOWN/${PV}/" git-version-gen || die
	eautoreconf
}
