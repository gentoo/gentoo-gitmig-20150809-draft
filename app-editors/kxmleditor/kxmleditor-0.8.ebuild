# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/kxmleditor/kxmleditor-0.8.ebuild,v 1.2 2002/11/29 17:31:47 danarmak Exp $
inherit kde-base

need-kde 3
DESCRIPTION="KDE XML Editor"
HOMEPAGE="http://kxmleditor.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

PATCHES="$FILESDIR/$P-gcc3.diff"

src_compile() {

    cd $S
    kde_src_compile myconf configure
    make distclean
    kde_src_compile myconf configure
    kde_src_compile make

}