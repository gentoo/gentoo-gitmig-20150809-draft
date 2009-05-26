# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdesvn/kdesvn-1.0.5.ebuild,v 1.2 2009/05/26 18:47:28 fauli Exp $

EAPI="2"

inherit cmake-utils qt3 kde-functions versionator

set-kdedir 3.5

My_PV=$(get_version_component_range 1-2)

DESCRIPTION="KDESvn is a frontend to the subversion vcs."
HOMEPAGE="http://www.alwins-world.de/wiki/programs/kdesvn"
SRC_URI="http://kdesvn.alwins-world.de/downloads/${P}.tar.bz2"

SLOT="3.5"
LICENSE="GPL-2"
KEYWORDS="~amd64 x86"
IUSE="debug"

RDEPEND="!<dev-util/kdesvn-1.0.5
	>=dev-util/subversion-1.4
	kde-base/kdesdk-kioslaves:3.5
	dev-db/sqlite"

DEPEND="${RDEPEND}
	>=dev-util/cmake-2.4"

need-kde 3.5

EXTRA_ECONF+="-DCMAKE_INSTALL_PREFIX=${KDEDIR}"

LANGS="ca cs de es fr gl it ja lt nl pa ru sv"

for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.0.0-asneeded.patch
	epatch "${FILESDIR}"/${PN}-1.0-subversion.patch

	sed -i -e "s:\${APR_CPP_FLAGS}:\${APR_CPP_FLAGS} \"-DQT_THREAD_SUPPORT\":" \
		"${S}"/CMakeLists.txt || die "QT_THREAD_SUPPORT sed failed"

	#remove kiosvn from CMakeLists.txt as it is already compiled from kdesdk-kioslaves
	sed -i '/kiosvn/d' "${S}"/src/CMakeLists.txt

	for X in ${LANGS} ; do
		use linguas_${X} || rm -f po/"${X}."*
	done

	cmake-utils_src_prepare
}

src_compile() {
	# fixing up lib paths
	sed -i "/^KDE3/ s:/usr/lib:${KDEDIR}/lib:g" "${WORKDIR}"/"${PN}"_build/CMakeCache.txt

	cmake-utils_src_compile
}

pkg_postinst() {
	if ! has_version 'kde-base/kompare'; then
		echo
		elog "For nice graphical diffs, install kde-base/kompare."
		echo
	fi
}
