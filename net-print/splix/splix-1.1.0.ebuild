# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/splix/splix-1.1.0.ebuild,v 1.1 2007/11/20 00:23:51 wschlich Exp $

inherit eutils toolchain-funcs

MY_P=${PN}-${PV/_p/-}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A set of CUPS printer drivers for SPL (Samsung Printer Language) printers"
HOMEPAGE="http://splix.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-print/cups
	net-print/cupsddk
	media-libs/jbigkit"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-fix-makefile.patch
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

pkg_postinst() {
	ebeep 5
	ewarn ""
	ewarn "You *MUST* make sure that the PPD files that CUPS is using"
	ewarn "for actually installed printers are updated if you upgraded"
	ewarn "from a previous version of splix!"
	ewarn "Otherwise you will be unable to print (your printer might"
	ewarn "spit out blank pages etc.)."
	ewarn "To do that, simply delete the corresponding PPD file in"
	ewarn "/etc/cups/ppd/, click on 'Modify Printer' belonging to the"
	ewarn "corresponding printer in the CUPS webinterface (usually"
	ewarn "reachable via http://localhost:631/) and choose the correct"
	ewarn "printer make and model, for example:"
	ewarn "'Samsung' -> 'Samsung ML-1610, 1.0 (en)'"
	ewarn ""
}
