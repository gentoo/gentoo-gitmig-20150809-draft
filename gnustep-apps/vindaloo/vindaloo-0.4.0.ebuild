# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/vindaloo/vindaloo-0.4.0.ebuild,v 1.2 2009/03/05 15:00:28 voyageur Exp $

inherit gnustep-2

S="${WORKDIR}/Etoile-${PV}/Services/User/${PN/v/V}"

DESCRIPTION="An Application for displaying and navigating in PDF documents."
HOMEPAGE="http://www.etoile-project.org"
SRC_URI="http://download.gna.org/etoile/etoile-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
IUSE=""

DEPEND="gnustep-libs/popplerkit
	gnustep-libs/iconkit"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}

	cd "${WORKDIR}/Etoile-${PV}"
	sed -i -e "s/-Werror//" etoile.make || die "sed failed"
}
