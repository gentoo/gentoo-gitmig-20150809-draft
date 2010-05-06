# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/simpleagenda/simpleagenda-0.41.ebuild,v 1.2 2010/05/06 08:43:07 voyageur Exp $

EAPI=2
inherit gnustep-2

MY_PN=SimpleAgenda
DESCRIPTION="a simple calendar and agenda application"
HOMEPAGE="http://coyote.octets.fr/pub/gnustep/"
SRC_URI="http://coyote.octets.fr/pub/gnustep/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-libs/libical-0.27
	>=virtual/gnustep-back-0.13.0"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_PN}-${PV}

src_prepare() {
	# Correct link command for --as-needed
	sed -i -e "s/ADDITIONAL_LDFLAGS/ADDITIONAL_TOOL_LIBS/" GNUmakefile.preamble || die "sed failed"
}
