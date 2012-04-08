# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmediawiki/libmediawiki-2.6.0_beta3.ebuild,v 1.1 2012/04/08 19:45:01 dilfridge Exp $

EAPI=4

DIGIKAMPN=digikam

KDE_LINGUAS=""
KDE_MINIMAL="4.8"

CMAKE_MIN_VERSION=2.8

inherit kde4-base

MY_P="${DIGIKAMPN}-${PV/_/-}"

DESCRIPTION="KDE C++ interface for MediaWiki based web service as wikipedia.org"
HOMEPAGE="http://www.digikam.org/"
SRC_URI="mirror://sourceforge/${DIGIKAMPN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS=""
IUSE=""
SLOT=4

DEPEND=""
RDEPEND=${DEPEND}

S=${WORKDIR}/${MY_P}/extra/${PN}

src_configure() {
	mycmakeargs=(
		-DFORCED_UNBUNDLE=ON
	)
	kde4-base_src_configure
}
