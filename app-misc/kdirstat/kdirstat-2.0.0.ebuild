# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/kdirstat/kdirstat-2.0.0.ebuild,v 1.5 2002/07/25 17:20:02 seemant Exp $

inherit kde-base

DESCRIPTION="KDirStat - nice KDE replacement to du command"
SRC_URI="http://kdirstat.sourceforge.net/download/${P}.tgz"
HOMEPAGE="http://kdirstat.sourceforge.net/"
S=${WORKDIR}/${P}

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86"

need-kde 2.2
