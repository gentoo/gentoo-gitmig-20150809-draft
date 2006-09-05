# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/knifty/knifty-0.4.2.ebuild,v 1.8 2006/09/05 21:56:09 gustavoz Exp $

inherit kde

DESCRIPTION="A native KWin window decoration for KDE 3.x."
HOMEPAGE="http://www.kde-look.org/content/show.php?content=8841"
SRC_URI="http://www.kde-look.org/content/files/8841-${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

need-kde 3.2
