# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/simpleagenda/simpleagenda-0.36.ebuild,v 1.5 2012/02/09 10:44:43 voyageur Exp $

inherit eutils gnustep-2

MY_PN=SimpleAgenda
DESCRIPTION="a simple calendar and agenda application"
HOMEPAGE="http://coyote.octets.fr/simpleagenda"
SRC_URI="http://coyote.octets.fr/pub/gnustep/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="dev-libs/libical
	>=virtual/gnustep-back-0.13.0"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_PN}-${PV}
