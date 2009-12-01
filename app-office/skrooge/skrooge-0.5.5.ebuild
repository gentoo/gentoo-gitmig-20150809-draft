# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/skrooge/skrooge-0.5.5.ebuild,v 1.1 2009/12/01 19:39:00 ssuominen Exp $

EAPI=2
KDE_LINGUAS="bg ca da de en_GB es et fr gl it lt ms nds nl pl pt pt_BR ro sk sv
tr uk zh_CN"
KDE_DOC_DIRS="doc doc-translations/%lingua_${PN}"
inherit kde4-base

DESCRIPTION="personal finances manager for KDE4, aiming at being simple and intuitive"
HOMEPAGE="http://www.kde-apps.org/content/show.php/skrooge?content=92458"
SRC_URI="http://websvn.kde.org/*checkout*/tags/${PN}/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug +handbook test"

DEPEND="dev-libs/libofx
	app-crypt/qca:2
	x11-libs/qt-sql[sqlite]"
RDEPEND="${DEPEND}
	>=kde-base/kdesdk-scripts-${KDE_MINIMAL}"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use test SKG_BUILD_TEST)"
	kde4-base_src_configure
}

DOCS="AUTHORS CHANGELOG README TODO"
