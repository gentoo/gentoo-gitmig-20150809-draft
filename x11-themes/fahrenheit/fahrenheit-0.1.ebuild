# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/fahrenheit/fahrenheit-0.1.ebuild,v 1.6 2006/11/28 00:12:33 flameeyes Exp $

ARTS_REQUIRED="never"

inherit kde

DESCRIPTION="A native KWin window decoration for KDE 3.2.x"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=2108"
SRC_URI="http://www.kde-look.org/content/files/2108-${P}.tar.bz2
	mirror://gentoo/kde-admindir-3.5.3.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE=""

need-kde 3.2
