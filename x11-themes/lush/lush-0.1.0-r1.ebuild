# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/lush/lush-0.1.0-r1.ebuild,v 1.1 2004/04/26 05:55:07 centic Exp $ 

inherit kde
need-kde 3

S="${WORKDIR}/lush"
DESCRIPTION="Lush KDE icon theme"
SRC_URI="http://projects.dims.org/~dave/distribution/${P}dave.tar.gz"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=5483"

KEYWORDS="~x86 ~alpha ~ppc ~sparc"
LICENSE="GPL-1"

SLOT="0"
IUSE=""

# stripping hangs and we've no binaries
RESTRICT="$RESTRICT nostrip"

src_compile() {
	return 0
}

src_install(){
	cd ${S}
	dodir $PREFIX/share/icons/
	cp -rf ${S} ${D}/${PREFIX}/share/icons/${P}
}
