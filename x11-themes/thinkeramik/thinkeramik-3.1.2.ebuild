# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/thinkeramik/thinkeramik-3.1.2.ebuild,v 1.1 2004/04/08 22:27:13 centic Exp $

inherit kde-base
need-kde 3.2

DESCRIPTION="A cool kde style modified from keramik"
SRC_URI="http://prefsx1.hp.infoseek.co.jp/tk040408/${P}.tar.gz"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=10919"

LICENSE="GPL-2"
SLOT="$KDEMAJORVER.$KDEMINORVER"
IUSE=""

KEYWORDS="~x86 ~ppc"

src_compile()
{
	./configure --prefix=$KDEDIR
	emake
}

