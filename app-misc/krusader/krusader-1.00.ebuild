# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/krusader/krusader-1.00.ebuild,v 1.8 2003/02/13 09:03:51 vapier Exp $

IUSE=""

inherit kde-base || die

S="${WORKDIR}/krusader-${PV}"
need-kde 2.1

DESCRIPTION="An oldschool Filemanager for KDE"
SRC_URI="http://krusader.sourceforge.net/distributions/${P}.tar.gz"
HOMEPAGE="http:/krusader.sourceforge.net/"


LICENSE="GPL-2"
KEYWORDS="x86"
