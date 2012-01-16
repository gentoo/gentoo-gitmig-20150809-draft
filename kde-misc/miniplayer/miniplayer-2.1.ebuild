# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/miniplayer/miniplayer-2.1.ebuild,v 1.1 2012/01/16 17:09:52 johu Exp $

EAPI=4

inherit kde4-base

DESCRIPTION="Multimedia Player Plasmoid"
HOMEPAGE="http://kde-look.org/content/show.php?content=95501"
SRC_URI="http://kde-look.org/CONTENT/content-files/95501-${P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep plasma-workspace)
"
