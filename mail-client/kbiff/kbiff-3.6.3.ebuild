# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/kbiff/kbiff-3.6.3.ebuild,v 1.3 2004/06/28 23:56:28 carlo Exp $

inherit kde

DESCRIPTION="KDE new mail notification utility (biff)"
HOMEPAGE="http://www.granroth.org/kbiff/"
SRC_URI="http://devel-home.kde.org/~granroth/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"
IUSE=""

DEPEND=">=kde-base/kdebase-3"
need-kde 3