# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libktorrent/libktorrent-1.0.1.ebuild,v 1.2 2010/06/22 19:30:24 scarabeus Exp $

EAPI="2"

KDE_LINGUAS="ar ast be bg ca ca@valencia cs da de el en_GB eo es et eu fi fr ga
gl hi hne hr hu is it ja km ku lt lv ms nb nds nl nn oc pl pt pt_BR ro ru se si
sk sl sr sr@latin sv tr uk zh_CN zh_TW"
inherit kde4-base

KTORRENT_VERSION="4.0.1"
DESCRIPTION="A BitTorrent library based on KDE Platform"
HOMEPAGE="http://ktorrent.org/"
SRC_URI="http://ktorrent.org/downloads/${KTORRENT_VERSION}/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
SLOT="4"
IUSE="debug doc"

COMMONDEPEND="
	app-crypt/qca:2
	dev-libs/gmp
"
DEPEND="${COMMONDEPEND}
	dev-libs/boost
	sys-devel/gettext
	doc? ( app-doc/doxygen[-nodot] )
"
RDEPEND="${COMMONDEPEND}"

src_compile() {
	cmake-utils_src_compile

	use doc && cmake-utils_src_compile docs
}

src_install() {
	use doc && HTML_DOCS="${CMAKE_BUILD_DIR}"/apidocs/html/

	cmake-utils_src_install
}
