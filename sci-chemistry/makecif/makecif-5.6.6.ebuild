# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/makecif/makecif-5.6.6.ebuild,v 1.8 2011/06/21 09:06:22 jlec Exp $

EAPI="3"

inherit eutils fortran-2 toolchain-funcs

DESCRIPTION="PDB --> CIF convertor"
HOMEPAGE="http://www.ysbl.york.ac.uk/~alexei/makecif.html"
SRC_URI="mirror://gentoo/${P}.tar.gz"

SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~amd64-linux ~x86-linux"
LICENSE="ccp4"
IUSE=""

S="${WORKDIR}"/${PN}

DEPEND=""
RDEPEND="
	sci-libs/monomer-db
	!<sci-chemistry/refmac-5.5.0110-r1"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-makefile.patch
}

src_compile() {
	cd src && emake clean
	emake \
		BLANC_FORT="$(tc-getFC) ${FFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		|| die
}

src_install() {
	dobin bin/* || die
	dodoc readme || die
}
