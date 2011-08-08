# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libkgeomap/libkgeomap-2.0.0.ebuild,v 1.2 2011/08/08 21:44:02 dilfridge Exp $

EAPI=4

DIGIKAMPN=digikam
KDE_MINIMAL="4.7"

inherit kde4-base

MY_P="${DIGIKAMPN}-${PV/_/-}"

DESCRIPTION="Wrapper library for world map components as marble, openstreetmap and googlemap"
HOMEPAGE="http://www.digikam.org/"
SRC_URI="mirror://sourceforge/${DIGIKAMPN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""
SLOT=4

DEPEND="
	$(add_kdebase_dep libkexiv2)
	$(add_kdebase_dep marble plasma)
	!media-libs/libkmap
"
RDEPEND=${DEPEND}

S="${WORKDIR}/${MY_P}/extra/${PN}"

PATCHES=( "${FILESDIR}/${P}-tests.patch" )

# bug 376763
#RESTRICT="test"
