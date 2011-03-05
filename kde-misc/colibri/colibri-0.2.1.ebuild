# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/colibri/colibri-0.2.1.ebuild,v 1.1 2011/03/05 15:48:24 dilfridge Exp $

EAPI=4

inherit kde4-base

KDE_LOOK="117147"

DESCRIPTION="Alternative to KDE4 Plasma notifications"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=${KDE-LOOK}"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/${KDE_LOOK}-${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=${DEPEND}
