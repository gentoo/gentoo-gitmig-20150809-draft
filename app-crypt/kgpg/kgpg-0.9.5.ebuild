# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/kgpg/kgpg-0.9.5.ebuild,v 1.6 2003/09/05 01:34:21 msterret Exp $

inherit kde-base
need-kde 3

IUSE=""
DESCRIPTION="KDE integration for GnuPG"
SRC_URI="http://devel-home.kde.org/~kgpg/src/${P}.tar.gz"
HOMEPAGE="http://devel-home.kde.org/~kgpg/index.html"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

newdepend "app-crypt/gnupg"
