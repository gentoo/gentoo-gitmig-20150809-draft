# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/kgpg/kgpg-1.0.0.ebuild,v 1.7 2004/04/04 20:43:48 lv Exp $

inherit kde
need-kde 3

IUSE=""
DESCRIPTION="KDE integration for GnuPG"
SRC_URI="http://devel-home.kde.org/~kgpg/src/${P}.tar.gz"
HOMEPAGE="http://devel-home.kde.org/~kgpg/index.html"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~amd64"

newdepend "app-crypt/gnupg"
