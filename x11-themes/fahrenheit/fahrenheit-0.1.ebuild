# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/fahrenheit/fahrenheit-0.1.ebuild,v 1.1 2004/06/30 20:51:45 jhuebel Exp $

inherit kde

DESCRIPTION="A native KWin window decoration for KDE 3.2.x"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=2108"
SRC_URI="http://www.kde-look.org/content/files/2108-${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

WANT_AUTOCONF=2.5

need-kde 3.2
