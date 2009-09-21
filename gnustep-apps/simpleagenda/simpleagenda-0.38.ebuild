# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/simpleagenda/simpleagenda-0.38.ebuild,v 1.2 2009/09/21 15:41:04 voyageur Exp $

inherit eutils gnustep-2

MY_PN=SimpleAgenda
DESCRIPTION="a simple calendar and agenda application"
HOMEPAGE="http://coyote.octets.fr/pub/gnustep/"
SRC_URI="http://coyote.octets.fr/pub/gnustep/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="dev-libs/libical
	>=virtual/gnustep-back-0.13.0"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_PN}-${PV}
