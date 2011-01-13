# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/choqok/choqok-0.9.98-r1.ebuild,v 1.1 2011/01/13 06:59:29 tampakrap Exp $

EAPI=3

KMNAME="extragear/network"

if [[ ${PV} != *9999* ]]; then
	KDE_LINGUAS="bg da de en_GB es et fr ja nb nds nl pa pl pt pt_BR sv tr uk zh_CN zh_TW"
	SRC_URI="http://choqok.gnufolks.org/pkgs/${PN}_${PV}.tar.bz2"
fi

inherit kde4-base

DESCRIPTION="A Free/Open Source micro-blogging client for KDE"
HOMEPAGE="http://choqok.gnufolks.org/"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug +handbook indicate"

DEPEND="dev-libs/qjson
		>=dev-libs/qoauth-1.0.1
		indicate? ( dev-libs/libindicate-qt )
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-libindicate.patch" )

src_prepare(){
	mycmakeargs=(
		$(cmake-utils_use indicate QTINDICATE_ENABLE)
	)

	kde4-base_src_prepare
}
