# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/kile/kile-1.2.ebuild,v 1.1 2002/10/04 10:19:33 danarmak Exp $
inherit kde-base

need-kde 3

DESCRIPTION="A Latex Editor and TeX shell for kde"
SRC_URI="http://xm1.net.free.fr/kile/${P}.tar.gz"
HOMEPAGE="http://xm1.net.free.fr/kile/index.html"

DEPEND="$DEPEND sys-devel/perl"
RDEPEND="${RDEPEND} app-text/tetex"

KEYWORDS="x86"
LICENSE="GPL-2"

src_unpack() {

    base_src_unpack
    
    cd $S/kile
    mv Makefile.in Makefile.in.orig
    sed -e 's:-lkghostview::g' Makefile.in.orig > Makefile.in
    
}
