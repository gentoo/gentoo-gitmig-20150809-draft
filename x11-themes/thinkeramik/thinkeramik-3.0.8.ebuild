# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/thinkeramik/thinkeramik-3.0.8.ebuild,v 1.1 2004/03/07 18:15:34 centic Exp $
inherit kde-base

need-kde 3.2

DESCRIPTION="A cool kde style modified from keramik"
SRC_URI="http://www.geocities.jp/prefsx1/tk040306/${P}.tar.gz"
HOMEPAGE="http://kde-look.org/content/show.php?content=10919"
LICENSE="GPL-2"
SLOT="$KDEMAJORVER.$KDEMINORVER"
KEYWORDS="~x86 ~amd64"

src_compile()
{
	./configure --prefix=$KDEDIR
	emake
}
