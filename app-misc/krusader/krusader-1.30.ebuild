# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/krusader/krusader-1.30.ebuild,v 1.4 2004/06/24 22:20:26 agriffis Exp $

IUSE=""

inherit kde
need-kde 3.1
KDEDIR=${KDEDIR/3.2/3.1}

DESCRIPTION="An oldschool Filemanager for KDE"
HOMEPAGE="http:/krusader.sourceforge.net/"
SRC_URI="mirror://sourceforge/krusader/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc"
