# Copyright 2002 Thomas Capricelli <orzel@freehackers.org>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/kvim/kvim-6.1.141_rc1.ebuild,v 1.6 2003/09/05 23:05:05 msterret Exp $

inherit kde-base
need-kde 3

S="${WORKDIR}/${P//_}"
DESCRIPTION="KDE editor based on vim"
SRC_URI="http://www.freehackers.org/kvim/dl/kvim-6.1.141rc1.tar.bz2"
HOMEPAGE="http://www.freehackers.org/kvim/"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

PATCHES="$FILESDIR/${P}-gcc2fix.patch"

myconf="$myconf --enable-gui=kde"

src_compile() {
	kde_src_compile myconf configure
	cd $S
	# emake does not work
	make || die
}

src_install() {
	kde_src_install
	dodoc BUGS README.txt README_src.txt TODO kvim.lsm IDEAS README.kvim README_lang.txt README_unix.txt
}
