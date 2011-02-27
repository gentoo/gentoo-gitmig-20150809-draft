# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/nepomukcontroller/nepomukcontroller-0.2.ebuild,v 1.1 2011/02/27 15:26:14 dilfridge Exp $

EAPI=3

KDE_MINIMAL="4.6"
inherit kde4-base

DESCRIPTION="KDE 4.6 systray applet that allows you to suspend and resume the Nepomuk file indexer"
HOMEPAGE="http://kde-apps.org/content/show.php?content=137088"
SRC_URI="http://kde-apps.org/CONTENT/content-files/137088-${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="
	dev-libs/soprano
	$(add_kdebase_dep nepomuk)
	$(add_kdebase_dep plasma-workspace)
"
DEPEND="${RDEPEND}"
