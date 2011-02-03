# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/choqok/choqok-1.0.ebuild,v 1.2 2011/02/03 12:28:56 tampakrap Exp $

EAPI=3

KMNAME="extragear/network"

if [[ ${PV} != *9999* ]]; then
	KDE_LINGUAS="bg da de en_GB es et fr ja nb nds nl pa pl pt pt_BR ru sv tr uk zh_CN zh_TW"
	SRC_URI="http://choqok.gnufolks.org/pkgs/${P}.tar.bz2"
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

src_prepare(){
	mycmakeargs=(
		$(cmake-utils_use !indicate QTINDICATE_DISABLE)
	)

	kde4-base_src_prepare
}
