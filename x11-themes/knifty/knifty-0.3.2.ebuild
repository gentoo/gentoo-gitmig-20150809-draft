# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/knifty/knifty-0.3.2.ebuild,v 1.5 2004/06/21 13:58:54 carlo Exp $

inherit kde

DESCRIPTION="A native KWin window decoration for KDE 3.x."
HOMEPAGE="http://www.kde-look.org/content/show.php?content=7290"
SRC_URI="http://www.kde-look.org/content/files/7290-${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc ppc"
IUSE=""

need-kde 3.1