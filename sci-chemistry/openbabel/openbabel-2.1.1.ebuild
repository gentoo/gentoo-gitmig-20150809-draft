# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/openbabel/openbabel-2.1.1.ebuild,v 1.1 2007/07/11 09:40:23 cryos Exp $

DESCRIPTION="Open Babel interconverts file formats used in molecular modeling"
SRC_URI="mirror://sourceforge/openbabel/${P}.tar.gz"
HOMEPAGE="http://openbabel.sourceforge.net/"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""
RDEPEND="!sci-chemistry/babel"

src_install () {
	make DESTDIR=${D} install || die "make install failed."
	dodoc AUTHORS ChangeLog NEWS README THANKS
	cd doc
	dohtml *.html *.png
	dodoc *.inc README* *.inc *.mol2
}
