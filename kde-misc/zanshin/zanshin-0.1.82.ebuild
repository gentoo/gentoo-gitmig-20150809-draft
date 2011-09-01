# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/zanshin/zanshin-0.1.82.ebuild,v 1.1 2011/09/01 20:44:19 dilfridge Exp $

EAPI=4
inherit kde4-base

DESCRIPTION="Getting Things Done application for KDE"
HOMEPAGE="https://projects.kde.org/projects/playground/pim/zanshin/"
SRC_URI="http://files.kde.org/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT=4
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	$(add_kdebase_dep kdepim-runtime '' 4.6.0)
	dev-libs/boost
"
DEPEND=${RDEPEND}
