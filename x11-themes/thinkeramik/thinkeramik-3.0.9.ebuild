# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/thinkeramik/thinkeramik-3.0.9.ebuild,v 1.1 2004/03/22 10:45:26 humpback Exp $
inherit kde-base

need-kde 3.2

DESCRIPTION="A cool kde style modified from keramik"
SRC_URI="http://www.geocities.jp/prefsx1/tk040311/${P}.tar.gz"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=10919"
LICENSE="GPL-2"
SLOT="$KDEMAJORVER.$KDEMINORVER"
KEYWORDS="~x86"

src_compile()
{
	./configure --prefix=$KDEDIR
	emake
}
