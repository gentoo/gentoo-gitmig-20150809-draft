# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/akonadi-google/akonadi-google-0.2_p20120201.ebuild,v 1.1 2012/02/06 23:02:30 dilfridge Exp $

EAPI=4

KDE_SCM="git"
EGIT_REPONAME="akonadi-google"
inherit kde4-base

DESCRIPTION="Google services integration in Akonadi"
HOMEPAGE="https://projects.kde.org/projects/playground/pim/akonadi-google"
LICENSE="GPL-2"

SRC_URI="http://dev.gentoo.org/~dilfridge/distfiles/${P}.tar.xz"

SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="oldpim"

DEPEND="
	$(add_kdebase_dep kdepimlibs semantic-desktop)
	dev-libs/libxslt
	dev-libs/qjson
	net-libs/libgcal
	oldpim? ( dev-libs/boost )
	!oldpim? ( $(add_kdebase_dep kdepimlibs semantic-desktop 4.6.0) )
"
RDEPEND=${DEPEND}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use oldpim KCAL)
	)
	kde4-base_src_configure
}
