# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: 
inherit kde-base

need-kde 3

DESCRIPTION="A cool kde style modified from keramik"
SRC_URI="http://kde-look.org/content/files/6986-${P}.tar.bz2"
HOMEPAGE="http://kde-look.org/content/show.php?content=6986"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

src_compile()
{
	./configure --prefix=$KDEDIR
	emake
}


