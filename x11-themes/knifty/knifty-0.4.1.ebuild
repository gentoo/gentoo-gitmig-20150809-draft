# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/knifty/knifty-0.4.1.ebuild,v 1.6 2004/08/03 19:36:00 centic Exp $

inherit kde

DESCRIPTION="A native KWin window decoration for KDE 3.x."
HOMEPAGE="http://www.kde-look.org/content/show.php?content=8841"
SRC_URI="http://www.kde-look.org/content/files/8841-${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc ppc"
IUSE=""

need-kde 3.2
