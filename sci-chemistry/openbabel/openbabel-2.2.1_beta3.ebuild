# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/openbabel/openbabel-2.2.1_beta3.ebuild,v 1.1 2009/02/18 21:44:47 cryos Exp $

inherit eutils

MY_PV="2.2.1b3-20090215-r2890"

DESCRIPTION="interconverts file formats used in molecular modeling"
HOMEPAGE="http://openbabel.sourceforge.net/"
SRC_URI="mirror://sourceforge/openbabel/${PN}-${MY_PV}.tar.gz"

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

RDEPEND="!sci-chemistry/babel
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	dev-libs/boost
	dev-lang/perl"

S=${WORKDIR}/${PN}-${MY_PV}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed."
	dodoc AUTHORS ChangeLog NEWS README THANKS
	cd doc
	dohtml *.html *.png
	dodoc *.inc README* *.inc *.mol2
}
