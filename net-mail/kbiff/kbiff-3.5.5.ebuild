# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/kbiff/kbiff-3.5.5.ebuild,v 1.3 2002/07/11 06:30:47 drobbins Exp $

inherit kde-base || die

need-kde 2.2

DESCRIPTION="KDE new mail notification utility (biff)"
SRC_URI="http://devel-home.kde.org/~granroth/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.granroth.org/kbiff/"

newdepend ">=kde-base/kdebase-2.2"
