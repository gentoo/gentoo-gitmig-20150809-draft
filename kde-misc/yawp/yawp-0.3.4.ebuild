# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/yawp/yawp-0.3.4.ebuild,v 1.1 2010/08/13 17:47:04 spatz Exp $

EAPI=2
KDE_LINGUAS="af cs de es fr he it pl ru sk sl"
inherit kde4-base

DESCRIPTION="Yet Another Weather Plasmoid"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=94106"
SRC_URI="mirror://sourceforge/yawp/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=kde-base/plasma-workspace-${KDE_MINIMAL}"

PATCHES=(
	"${FILESDIR}/${P}-kde45.patch"
)

DOCS="README TODO"
