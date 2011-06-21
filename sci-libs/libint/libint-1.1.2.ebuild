# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libint/libint-1.1.2.ebuild,v 1.3 2011/06/21 08:31:23 jlec Exp $

inherit eutils fortran-2

DESCRIPTION="Matrix elements (integrals) evaluation over Cartesian Gaussian functions"
HOMEPAGE="http://www.ccmst.gatech.edu/evaleev/libint/"
SRC_URI="http://www.ccmst.gatech.edu/evaleev/libint/src/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/dont-append-mcpu.patch
}

src_compile() {
	sed -i \
		-e "s:^COPTIONS_OPT=.*:COPTIONS_OPT=\"${CFLAGS}\":g" \
		-e "s:^CXXOPTIONS_OPT=.*:CXXOPTIONS_OPT=\"${CXXFLAGS}\":g" \
		${S}/configure

	econf \
		--enable-shared \
		--enable-deriv \
		--enable-r12
	emake || die "emake failed"
}

src_install() {
	#make DESTDIR=${D} install || die
	einstall || die
}
