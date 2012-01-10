# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/colibri/colibri-0.2.2.ebuild,v 1.1 2012/01/10 16:30:19 johu Exp $

EAPI=4

KDE_LINGUAS="cs de es it pt_BR sk tr"
inherit kde4-base

KDE_LOOK="117147"

DESCRIPTION="Alternative to KDE4 Plasma notifications"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=${KDE_LOOK}"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/${KDE_LOOK}-${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=${DEPEND}
