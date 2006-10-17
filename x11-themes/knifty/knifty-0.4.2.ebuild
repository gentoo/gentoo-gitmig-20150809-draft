# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/knifty/knifty-0.4.2.ebuild,v 1.10 2006/10/17 12:21:55 flameeyes Exp $

ARTS_REQUIRED="never"

inherit kde

DESCRIPTION="A native KWin window decoration for KDE 3.x."
HOMEPAGE="http://www.kde-look.org/content/show.php?content=8841"
SRC_URI="http://www.kde-look.org/content/files/8841-${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="|| ( kde-base/kwin kde-base/kdebase )"

RDEPEND="${DEPEND}"

need-kde 3.2

