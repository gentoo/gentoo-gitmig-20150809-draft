# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/kdirstat/kdirstat-2.0.0.ebuild,v 1.8 2003/02/13 09:02:51 vapier Exp $

inherit kde-base

DESCRIPTION="KDirStat - nice KDE replacement to du command"
SRC_URI="http://kdirstat.sourceforge.net/download/${P}.tgz"
HOMEPAGE="http://kdirstat.sourceforge.net/"
S=${WORKDIR}/${P}


LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86"

need-kde 2.2
