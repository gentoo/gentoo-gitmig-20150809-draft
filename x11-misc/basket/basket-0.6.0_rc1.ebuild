# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/basket/basket-0.6.0_rc1.ebuild,v 1.1 2006/10/18 18:47:14 troll Exp $

inherit eutils kde autotools versionator

MY_PV="${PV/_rc*/}"

DESCRIPTION="A DropDrawers clone. Multiple information organizer"
HOMEPAGE="http://basket.kde.org/"
# mirror of rc sources, because of the tarball name collision
#SRC_URI="http://basket.kde.org/downloads/${P}.tar.gz"
SRC_URI="http://vivid.dat.pl/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

S="${WORKDIR}/${PN}-${MY_PV}"

need-kde 3.3

