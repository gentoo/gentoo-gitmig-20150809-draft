# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdesvn/kdesvn-1.4.1.ebuild,v 1.4 2009/12/17 17:17:11 hwoarang Exp $

EAPI="2"

KDE_LINGUAS="cs de es fr ja lt nl ru"
inherit kde4-base

DESCRIPTION="KDESvn is a frontend to the subversion vcs."
HOMEPAGE="http://www.alwins-world.de/wiki/programs/kdesvn"
SRC_URI="http://kdesvn.alwins-world.de/downloads/${P}.tar.bz2"

SLOT="4"
LICENSE="GPL-2"
KEYWORDS="amd64 x86"
IUSE="debug +handbook"

DEPEND="
	dev-db/sqlite
	>=dev-util/subversion-1.4
	!dev-util/qsvn
"
RDEPEND="${DEPEND}
	!dev-util/kdesvn:1.2
	>=kde-base/kdesdk-kioslaves-${KDE_MINIMAL}
"

src_configure() {
	append-cppflags -DQT_THREAD_SUPPORT
	mycmakeargs="${mycmakeargs}
		-DLIB_INSTALL_DIR=${PREFIX}/$(get_libdir)"

	kde4-base_src_configure
}

src_install() {
	kde4-base_src_install

	# Remove kio svn service types - provided by kdesdk-kioslaves
	rm -f "${D}/${PREFIX}"/share/kde4/services/svn{,+ssh,+https,+file,+http}.protocol
}

pkg_postinst() {
	if ! has_version 'kde-base/kompare'; then
		echo
		elog "For nice graphical diffs, install kde-base/kompare."
		echo
	fi

	kde4-base_pkg_postinst
}
