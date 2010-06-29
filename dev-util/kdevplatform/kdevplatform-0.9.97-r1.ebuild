# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdevplatform/kdevplatform-0.9.97-r1.ebuild,v 1.11 2010/06/29 00:21:07 reavertm Exp $

EAPI="2"

# Bug 276208
RESTRICT="test"

KMNAME="extragear/sdk"
inherit kde4-base

if [[ ${PV} == *9999* ]]; then
	KDEVELOP_PV="9999"
else
	inherit versionator
	KDEVELOP_PV="$(($(get_major_version)+3)).$(get_after_major_version)"
fi
DESCRIPTION="KDE development support libraries and apps"
HOMEPAGE="http://www.kdevelop.org/"
[[ ${PV} != *9999* ]] && SRC_URI="mirror://kde/unstable/kdevelop/${KDEVELOP_PV}/src/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="amd64 ppc ~ppc64 x86"
SLOT="4"
# Moved to playground for now
# bazaar git
IUSE="cvs debug mercurial subversion"

DEPEND="
	dev-libs/boost
	subversion? ( >=dev-vcs/subversion-1.3 )
"
# Moved to playground for now
# bazaar? ( dev-util/bzr )
# git? ( dev-vcs/git )
# block - some plugins moved to kdevplatform from kdevelop
RDEPEND="${DEPEND}
	!<dev-util/kdevelop-${KDEVELOP_PV}
	cvs? ( dev-vcs/cvs )
	mercurial? ( dev-vcs/mercurial )
"

src_prepare() {
	kde4-base_src_prepare

	# FindKDevPlatform.cmake is installed by kdelibs
	sed -i \
		-e '/cmakeFiles/s/^/#DONOTINSTALL/' \
		cmake/modules/CMakeLists.txt || die
}

# Moved to playground for now
# $(cmake-utils_use_build bazaar)
# $(cmake-utils_use_build git)
src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_build cvs)
		$(cmake-utils_use_build mercurial)
		$(cmake-utils_use_build subversion)
		$(cmake-utils_use_with subversion SubversionLibrary)
	)

	kde4-base_src_configure
}
