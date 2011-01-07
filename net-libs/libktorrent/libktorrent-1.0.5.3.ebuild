# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libktorrent/libktorrent-1.0.5.3.ebuild,v 1.3 2011/01/07 23:43:14 hwoarang Exp $

EAPI=3
KMNAME="extragear/network"
if [[ ${PV} != 9999* ]]; then
	inherit versionator
	# upstream likes to skip that _ in beta releases
	KTORRENT_VERSION=$(($(get_major_version)+3)).$(get_version_component_range 2-3)
	MY_PV="${PV/_/}"
	MY_PV=$(replace_version_separator 3 '-' ${MY_PV}) # ZOMGHACK REMOVE ME NEXT TIME
	MY_P="${PN}-${MY_PV}"

	KDE_LINGUAS="ar ast be bg ca ca@valencia cs da de el en_GB eo es et eu
		fi fr ga gl hi hne hr hu is it ja km ku lt lv ms nb nds nl nn oc pl
		pt pt_BR ro ru se si sk sl sr sr@ijekavian sr@ijekavianlatin
		sr@latin sv tr uk zh_CN zh_TW"
	SRC_URI="http://ktorrent.org/downloads/${KTORRENT_VERSION}/${MY_P}.tar.bz2"
	S="${WORKDIR}"/"${MY_P}"
fi
inherit kde4-base

DESCRIPTION="A BitTorrent library based on KDE Platform"
HOMEPAGE="http://ktorrent.org/"

LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc ~ppc64 ~x86"
SLOT="4"
IUSE="debug doc"

RDEPEND="
	app-crypt/qca:2
	dev-libs/gmp
"
DEPEND="${RDEPEND}
	dev-libs/boost
	sys-devel/gettext
	doc? ( app-doc/doxygen[-nodot] )
"

src_compile() {
	cmake-utils_src_compile

	use doc && cmake-utils_src_compile docs
}

src_install() {
	use doc && HTML_DOCS=( "${CMAKE_BUILD_DIR}/apidocs/html/" )

	cmake-utils_src_install
}
