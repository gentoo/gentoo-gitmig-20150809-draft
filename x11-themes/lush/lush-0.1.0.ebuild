# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/lush/lush-0.1.0.ebuild,v 1.7 2004/08/14 13:55:50 swegener Exp $

inherit kde
need-kde 3

S="${WORKDIR}/lush"
DESCRIPTION="Lush KDE icon theme"
SRC_URI="http://projects.dims.org/~dave/distribution/${P}dave.tar.gz"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=5483"
KEYWORDS="x86 ~alpha ppc ~sparc amd64"
SLOT="0"
LICENSE="GPL-1"
IUSE=""

# stripping hangs and we've no binaries
RESTRICT="$RESTRICT nostrip"

src_compile() {
	return 0
}

src_install(){
	cd ${S}
	dodir $PREFIX/share/icons/
	cp -rf ${S} ${D}/${PREFIX}/share/icons
}
