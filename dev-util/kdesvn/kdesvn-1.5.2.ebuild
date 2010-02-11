# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdesvn/kdesvn-1.5.2.ebuild,v 1.1 2010/02/11 11:21:56 ssuominen Exp $

EAPI=3
KDE_LINGUAS="de es fr ja lt nl pt_BR ro ru"
inherit kde4-base

DESCRIPTION="KDESvn is a frontend to the subversion vcs."
HOMEPAGE="http://kdesvn.alwins-world.de/"
SRC_URI="http://kdesvn.alwins-world.de/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug +handbook"

DEPEND=">=dev-db/sqlite-3
	>=dev-util/subversion-1.4
	!dev-util/qsvn"
RDEPEND="${DEPEND}
	>=kde-base/kdesdk-kioslaves-${KDE_MINIMAL}"

DOCS="AUTHORS ChangeLog TODO"

src_configure() {
	append-cppflags -DQT_THREAD_SUPPORT

	mycmakeargs+=( "-DLIB_INSTALL_DIR=${EPREFIX}/usr/$(get_libdir)" )

	kde4-base_src_configure
}

src_install() {
	kde4-base_src_install

	# Remove kio svn service types - provided by kdesdk-kioslaves.
	# Last version checked: 1.5.1
	rm -f "${D}/${PREFIX}"/share/kde4/services/svn{,+ssh,+https,+file,+http}.protocol
}
