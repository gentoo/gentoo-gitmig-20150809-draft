# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/kbiff/kbiff-3.7.ebuild,v 1.2 2004/06/03 16:07:26 dholm Exp $

inherit kde-base

need-kde 3

DESCRIPTION="KDE new mail notification utility (biff)"
SRC_URI="http://devel-home.kde.org/~granroth/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.granroth.org/kbiff/"

LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc"

newdepend ">=kde-base/kdebase-3"
