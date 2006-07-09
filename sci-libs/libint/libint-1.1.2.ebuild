# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libint/libint-1.1.2.ebuild,v 1.2 2006/07/09 07:11:27 dberkholz Exp $

inherit eutils

DESCRIPTION="Used to evaluate traditional and novel two-body matrix elements (integrals) over Cartesian Gaussian functions"
HOMEPAGE="http://www.ccmst.gatech.edu/evaleev/libint/"
SRC_URI="http://www.ccmst.gatech.edu/evaleev/libint/src/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}"

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
		--enable-r12 \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	#make DESTDIR=${D} install || die
	einstall || die
}
