# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/krusader/krusader-1.03_beta2.ebuild,v 1.1 2002/07/26 07:23:29 rphillips Exp $
inherit kde-base || die

need-kde 3

DESCRIPTION="An oldschool Filemanager for KDE"
HOMEPAGE="http:/krusader.sourceforge.net/"

P=${P/_/-}
SRC_URI="http://krusader.sourceforge.net/dev/${P}.tar.gz"
S=${WORKDIR}/${P}

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
