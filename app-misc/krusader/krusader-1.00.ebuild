# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/krusader/krusader-1.00.ebuild,v 1.5 2002/07/27 10:44:30 seemant Exp $

inherit kde-base || die

S="${WORKDIR}/krusader-${PV}"
need-kde 2.1

DESCRIPTION="An oldschool Filemanager for KDE"
SRC_URI="http://krusader.sourceforge.net/distributions/${P}.tar.gz"
HOMEPAGE="http:/krusader.sourceforge.net/"


LICENSE="GPL-2"
KEYWORDS="x86"
