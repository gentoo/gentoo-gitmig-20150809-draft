# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Grant Goodyear <g2boojum@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/kbiff/kbiff-3.5.5.ebuild,v 1.2 2002/05/21 18:14:11 danarmak Exp $

inherit kde-base || die

need-kde 2.2

DESCRIPTION="KDE new mail notification utility (biff)"
SRC_URI="http://devel-home.kde.org/~granroth/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.granroth.org/kbiff/"

newdepend ">=kde-base/kdebase-2.2"
