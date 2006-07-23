# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/ridge/ridge-0.3.2.ebuild,v 1.3 2006/07/23 17:16:02 flameeyes Exp $

inherit kde

DESCRIPTION="A native KWin window decoration for KDE 3.2.x"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=10429"
SRC_URI="http://www.kde-look.org/content/files/10429-${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

need-kde 3.2
