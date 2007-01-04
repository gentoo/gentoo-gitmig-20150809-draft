# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/splix/splix-1.0.1_beta2.ebuild,v 1.2 2007/01/04 00:26:21 wschlich Exp $

inherit eutils toolchain-funcs

MY_P=${PN}-${PV/_/-}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A set of CUPS printer drivers for SPL (Samsung Printer Language) printers"
HOMEPAGE="http://splix.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="net-print/cups"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/fixMakefile.patch
}

src_compile() {
	emake CXX="$(tc-getCXX)" || die "emake failed"
}

src_install() {
	CUPSFILTERDIR="$(cups-config --serverbin)/filter"
	CUPSPPDDIR="$(cups-config --datadir)/model"

	dodir "${CUPSFILTERDIR}"
	dodir "${CUPSPPDDIR}"
	emake DESTDIR="${D}" install || die "emake install failed"
}
