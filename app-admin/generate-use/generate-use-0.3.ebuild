# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/generate-use/generate-use-0.3.ebuild,v 1.2 2003/06/29 15:24:07 aliz Exp $

DESCRIPTION="A USE var generator for Gentoo Linux(gtk+2)"
HOMEPAGE="http://www.lordvan.com/Projects/Linux/Gentoo/gentoolkit-gui/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
#         http://www.lordvan.com/Projects/Linux/Gentoo/gentoolkit-gui/${P}.tar.bz2
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~hppa ~arm ~alpha"
IUSE=""

RDEPEND=">=dev-python/pygtk-1.99.13"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}"

src_compile() {
    # nothing to compile
    return
}

src_install() {
    dobin generate-use
    dodoc AUTHORS  ChangeLog  LICENSE  README  TODO
   	
}
