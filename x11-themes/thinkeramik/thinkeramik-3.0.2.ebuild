# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: 
inherit kde-base

need-kde 3.2

DESCRIPTION="A cool kde style modified from keramik"
SRC_URI="http://www.geocities.jp/prefsx1/${P}.tar.gz"
HOMEPAGE="http://kde-look.org/content/show.php?content=10164"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

src_compile()
{
	./configure --prefix=$KDEDIR
	emake
}


