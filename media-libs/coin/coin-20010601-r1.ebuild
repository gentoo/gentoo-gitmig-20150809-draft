# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/coin/coin-20010601-r1.ebuild,v 1.3 2002/07/22 14:37:05 seemant Exp $


MY_P=${P/c/C}
S=${WORKDIR}/Coin
DESCRIPTION="An OpenSource implementation of SGI's OpenInventor"
SRC_URI="ftp://ftp.coin3d.org/pub/snapshots/${MY_P}.tar.gz"
HOMEPAGE="http://www.coin3d.org"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86"

DEPEND="virtual/x11
	virtual/opengl"

src_compile() {

	local myconf
	use X || myconf="--without-x"

	econf ${myconf} || die
	make || die

}

src_install () {

	einstall || die

	dodoc AUTHORS COPYING ChangeLog* HACKING LICENSE* NEWS README*
	docinto txt
	dodoc docs/*.txt docs/coin.doxygen docs/whitepapers/*.txt

}
