# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/kmldonkey/kmldonkey-0.11.ebuild,v 1.3 2009/05/25 19:52:30 scarabeus Exp $

ARTS_REQUIRED="never"

inherit kde

DESCRIPTION="KMLDonkey is a KDE frontend for the MLDonkey P2P application."
HOMEPAGE="http://www.kmldonkey.org/"
SRC_URI="mirror://kde/stable/apps/KDE3.x/network/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="|| ( =kde-base/kcontrol-3.5* =kde-base/kdebase-3.5* )"

PATCHES=(
	"${FILESDIR}/${PN}-0.11-sandbox.patch"
)

need-kde 3.5

src_unpack() {
	kde_src_unpack

	rm -f "${S}/configure"
}
