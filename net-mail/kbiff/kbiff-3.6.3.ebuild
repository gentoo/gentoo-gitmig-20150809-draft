# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/kbiff/kbiff-3.6.3.ebuild,v 1.1 2002/12/05 11:21:48 danarmak Exp $

inherit kde-base || die

need-kde 3

DESCRIPTION="KDE new mail notification utility (biff)"
SRC_URI="http://devel-home.kde.org/~granroth/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.granroth.org/kbiff/"


LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

newdepend ">=kde-base/kdebase-3"
