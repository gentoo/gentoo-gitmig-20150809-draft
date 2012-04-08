# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libkgeomap/libkgeomap-2.6.0_beta3.ebuild,v 1.1 2012/04/08 19:46:10 dilfridge Exp $

EAPI=4

DIGIKAMPN=digikam
KDE_MINIMAL="4.8"

inherit kde4-base

MY_P="${DIGIKAMPN}-${PV/_/-}"

DESCRIPTION="Wrapper library for world map components as marble, openstreetmap and googlemap"
HOMEPAGE="http://www.digikam.org/"
SRC_URI="mirror://sourceforge/${DIGIKAMPN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS=""
IUSE=""
SLOT=4

DEPEND="
	$(add_kdebase_dep libkexiv2)
	$(add_kdebase_dep marble kde,plasma)
"
RDEPEND=${DEPEND}

S="${WORKDIR}/${MY_P}/extra/${PN}"
