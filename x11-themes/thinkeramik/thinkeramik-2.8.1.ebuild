# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/thinkeramik/thinkeramik-2.8.1.ebuild,v 1.7 2004/08/14 13:57:01 swegener Exp $

inherit kde
need-kde 3.1

DESCRIPTION="A cool kde style modified from keramik"
SRC_URI="http://kde-look.org/content/files/6986-${P}.tar.bz2"
HOMEPAGE="http://kde-look.org/content/show.php?content=6986"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ppc"

IUSE=""
SLOT="0"

src_compile()
{
	./configure --prefix=$KDEDIR
	emake
}


