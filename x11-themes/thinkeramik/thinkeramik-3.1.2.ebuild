# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/thinkeramik/thinkeramik-3.1.2.ebuild,v 1.4 2004/06/05 18:01:34 carlo Exp $

inherit kde
need-kde 3.2

DESCRIPTION="A cool kde style modified from keramik"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=10919"
SRC_URI="http://prefsx1.hp.infoseek.co.jp/tk040408/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~amd64"
IUSE=""

src_compile()
{
	./configure --prefix=$KDEDIR
	emake
}

