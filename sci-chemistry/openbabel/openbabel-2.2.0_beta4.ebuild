# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/openbabel/openbabel-2.2.0_beta4.ebuild,v 1.1 2008/03/01 17:50:03 cryos Exp $

DESCRIPTION="Open Babel interconverts file formats used in molecular modeling"
SRC_URI="mirror://sourceforge/openbabel/${PN}-2.2.0b4-20080301-r2299.tar.gz"
HOMEPAGE="http://openbabel.sourceforge.net/"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""
RDEPEND="!sci-chemistry/babel"

S=${WORKDIR}/${PN}-2.2.0b4

src_install () {
	make DESTDIR="${D}" install || die "make install failed."
	dodoc AUTHORS ChangeLog NEWS README THANKS
	cd doc
	dohtml *.html *.png
	dodoc *.inc README* *.inc *.mol2
}
