# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/igal/igal-1.4.ebuild,v 1.5 2004/07/14 17:44:16 agriffis Exp $

DESCRIPTION="Static HTML image gallery generator"
HOMEPAGE="http://www.stanford.edu/~epop/igal/"
SRC_URI="http://www.stanford.edu/~epop/igal/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha"
IUSE=""

RDEPEND="dev-lang/perl
		media-gfx/imagemagick"

src_unpack(){
	unpack ${P}.tar.gz
	patch -p0 < ${FILESDIR}/${P}-gentoo.diff
}

src_compile(){
	make || die
}

src_install(){
	dodir /usr/share/igal/lib
	insinto /usr/share/igal/lib
	doins indextemplate.html
	doins slidetemplate.html
	doins tile.png
	doins igal.css
	into /usr
	dobin igal
	doman igal.1
	dodoc ChangeLog COPYING README THANKS
}
