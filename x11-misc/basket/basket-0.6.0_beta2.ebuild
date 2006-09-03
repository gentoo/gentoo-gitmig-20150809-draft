# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/basket/basket-0.6.0_beta2.ebuild,v 1.1 2006/09/03 11:10:28 nelchael Exp $

inherit eutils kde autotools versionator

MY_PV=${PV/_beta/Beta}

DESCRIPTION="A DropDrawers clone. Multiple information organizer"
HOMEPAGE="http://basket.kde.org/"
SRC_URI="http://basket.kde.org/downloads/${PN}-${MY_PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="virtual/fam"

S="${WORKDIR}/${PN}-${MY_PV}"

need-kde 3.3

