# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/thinkeramik/thinkeramik-3.2.1.ebuild,v 1.1 2004/05/26 00:05:28 caleb Exp $

inherit kde-base
need-kde 3.2

DESCRIPTION="A cool kde style modified from keramik"
SRC_URI="http://prefsx1.hp.infoseek.co.jp/tk040429/${P}.tar.gz"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=10919"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="$KDEMAJORVER.$KDEMINORVER"
IUSE=""

KEYWORDS="~x86 ~ppc"

src_compile()
{
	./configure --prefix=$KDEDIR
	emake
}

