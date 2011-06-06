# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/kdesvn/kdesvn-1.5.5.ebuild,v 1.6 2011/06/06 20:47:14 abcd Exp $

EAPI="3"

KDE_LINGUAS="de es fr ja lt pt_BR ro"
inherit kde4-base

DESCRIPTION="KDESvn is a frontend to the subversion vcs."
HOMEPAGE="http://kdesvn.alwins-world.de/"
if [[ ${PV} = 9999* ]]; then
	ESVN_REPO_URI="http://www.alwins-world.de/repos/kdesvn/trunk/"
	ESVN_PROJECT="kdesvn"
else
	SRC_URI="http://kdesvn.alwins-world.de/downloads/${P}.tar.bz2"
fi

LICENSE="GPL-2"
KEYWORDS="amd64 x86"
SLOT="4"
IUSE="debug +handbook"

DEPEND="
	>=dev-db/sqlite-3
	dev-libs/apr:1
	>=dev-vcs/subversion-1.4
	sys-devel/gettext
"
RDEPEND="${DEPEND}
	!<kde-base/kdesdk-kioslaves-4.3.5
	!>=kde-base/kdesdk-kioslaves-4.3.5[subversion]
"

src_configure() {
	append-cppflags -DQT_THREAD_SUPPORT

	[[ ${PV} = 9999* ]] && mycmakeargs=(-DDAILY_BUILD=ON)

	kde4-base_src_configure
}
