# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/generate-use/generate-use-0.3.ebuild,v 1.8 2004/07/14 01:48:35 agriffis Exp $

DESCRIPTION="A USE var generator for Gentoo Linux(gtk+2)"
HOMEPAGE="http://www.lordvan.com/Projects/Linux/Gentoo/gentoolkit-gui/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
#         http://www.lordvan.com/Projects/Linux/Gentoo/gentoolkit-gui/${P}.tar.bz2
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~hppa alpha"
IUSE=""

DEPEND=">=dev-python/pygtk-1.99.13"


src_compile() {
	# nothing to compile
	return
}

src_install() {
	dobin generate-use
	dodoc AUTHORS  ChangeLog  LICENSE  README  TODO
}
