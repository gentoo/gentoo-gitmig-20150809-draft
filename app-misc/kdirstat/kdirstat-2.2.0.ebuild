# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/kdirstat/kdirstat-2.2.0.ebuild,v 1.7 2003/02/13 09:02:56 vapier Exp $

inherit kde-base

DESCRIPTION="KDirStat - nice KDE replacement to du command"
SRC_URI="http://kdirstat.sourceforge.net/download/${P}.tgz"
HOMEPAGE="http://kdirstat.sourceforge.net/"


LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86"

need-kde 3

