# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Grant Goodyear <g2boojum@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/kbiff/kbiff-3.5.4.ebuild,v 1.1 2001/12/10 17:26:28 g2boojum Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kdelibs 2.2
need-qt 2.2

DESCRIPTION="KDE new mail notification utility (biff)"
SRC_URI="http://devel-home.kde.org/~granroth/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.granroth.org/kbiff/"

S=${WORKDIR}/${P}

NEWDEPEND=">=kde-base/kdebase-2.2"

DEPEND="$DEPEND $NEWDEPEND"
RDEPEND="$RDEPEND $NEWDEPEND"
