# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/kbiff/kbiff-3.6.3.ebuild,v 1.5 2004/02/22 16:19:41 agriffis Exp $

inherit kde-base

need-kde 3

DESCRIPTION="KDE new mail notification utility (biff)"
SRC_URI="http://devel-home.kde.org/~granroth/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.granroth.org/kbiff/"


LICENSE="GPL-2"
KEYWORDS="x86 sparc"

newdepend ">=kde-base/kdebase-3"
