# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/polyester/polyester-1.0.1.ebuild,v 1.2 2008/02/19 02:12:56 ingmar Exp $

inherit kde

DESCRIPTION="Widget style + kwin decoration both aimed to be a good balance between eye candy and simplicity."
HOMEPAGE="http://www.kde-look.org/content/show.php?content=27968"
SRC_URI="http://www.notmart.org/files/${P}.tar.bz2"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| ( =kde-base/kwin-3.5* =kde-base/kdebase-3.5* )"

need-kde 3.4
