# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/kile/kile-1.6.3.ebuild,v 1.3 2004/06/22 22:58:07 kugelfang Exp $

inherit kde
DEPEND="dev-lang/perl"
RDEPEND="$RDEPEND virtual/tetex"
need-kde 3.1

DESCRIPTION="A Latex Editor and TeX shell for kde"
SRC_URI="mirror://sourceforge/kile/${P}.tar.gz"
HOMEPAGE="http://kile.sourceforge.net"

IUSE=""
SLOT=0

KEYWORDS="x86 amd64 ~sparc ~ppc"
LICENSE="GPL-2"

