# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/openbabel/openbabel-2.2.0.ebuild,v 1.2 2008/11/02 07:46:39 vapier Exp $

inherit eutils

DESCRIPTION="interconverts file formats used in molecular modeling"
HOMEPAGE="http://openbabel.sourceforge.net/"
SRC_URI="mirror://sourceforge/openbabel/${P}.tar.gz"

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

RDEPEND="!sci-chemistry/babel
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	dev-libs/boost
	dev-lang/perl"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed."
	dodoc AUTHORS ChangeLog NEWS README THANKS
	cd doc
	dohtml *.html *.png
	dodoc *.inc README* *.inc *.mol2
}
