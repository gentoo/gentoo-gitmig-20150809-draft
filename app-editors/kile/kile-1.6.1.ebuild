# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/kile/kile-1.6.1.ebuild,v 1.4 2004/06/24 21:57:42 agriffis Exp $

inherit kde
need-kde 3.1

IUSE=""
DESCRIPTION="A Latex Editor and TeX shell for kde"
SRC_URI="mirror://sourceforge/kile/${P}.tar.gz"
HOMEPAGE="http://kile.sourceforge.net"
SLOT=0
DEPEND="$DEPEND dev-lang/perl"
RDEPEND="$RDEPEND virtual/tetex"

KEYWORDS="x86 amd64 ~sparc"
LICENSE="GPL-2"
