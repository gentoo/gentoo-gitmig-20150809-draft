# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libkvkontakte/libkvkontakte-2.4.1.ebuild,v 1.3 2012/01/16 23:58:42 ago Exp $

EAPI=4

DIGIKAMPN=digikam

KDE_LINGUAS=""
KDE_MINIMAL="4.7"

CMAKE_MIN_VERSION=2.8

inherit kde4-base

MY_P="${DIGIKAMPN}-${PV/_/-}"

DESCRIPTION="Library for accessing the features of social networking site vkontakte.ru"
HOMEPAGE="http://www.digikam.org/"
SRC_URI="mirror://sourceforge/${DIGIKAMPN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="amd64 x86"
IUSE=""
SLOT=4

DEPEND=">=dev-libs/qjson-0.7.0"
RDEPEND=${DEPEND}

S=${WORKDIR}/${MY_P}/extra/${PN}

PATCHES=( "${FILESDIR}/${PN}-2.2.0-libdir.patch" )

src_configure() {
	mycmakeargs=(
		-DFORCED_UNBUNDLE=ON
	)
	kde4-base_src_configure
}
