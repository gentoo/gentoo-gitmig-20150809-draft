# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/krusader/krusader-1.03_beta1-r1.ebuild,v 1.5 2002/10/04 04:56:14 vapier Exp $
inherit kde-base || die

need-kde 3

DESCRIPTION="An oldschool Filemanager for KDE"
HOMEPAGE="http:/krusader.sourceforge.net/"

P=${P/_/-}
SRC_URI="http://krusader.sourceforge.net/dev/${P}.tar.gz"
S=${WORKDIR}/${P}


LICENSE="GPL-2"
KEYWORDS="x86"
