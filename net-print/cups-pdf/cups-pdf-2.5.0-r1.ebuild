# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/cups-pdf/cups-pdf-2.5.0-r1.ebuild,v 1.1 2010/08/07 13:41:42 hwoarang Exp $

inherit toolchain-funcs multilib

DESCRIPTION="Provides a virtual printer for CUPS to produce PDF files."
HOMEPAGE="http://www.cups-pdf.de/"
SRC_URI="http://www.cups-pdf.de/src/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="net-print/cups
	app-text/ghostscript-gpl"
RDEPEND="${DEPEND}"

src_compile() {
	cd "${S}"/src
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} -o cups-pdf cups-pdf.c || die "Compilation failed."
}

src_install () {
	exeinto $(cups-config --serverbin)/backend
	has_version '>=net-print/cups-1.2' && exeopts -m0700
	doexe src/cups-pdf || die "doexe cups-pdf failed."

	insinto /usr/share/cups/model
	doins extra/CUPS-PDF.ppd || die "doins CUPS-PDF.ppd failed."

	insinto /etc/cups
	doins extra/cups-pdf.conf || die "doins cups-pdf.conf failed."

	dodoc ChangeLog README || die "dodoc failed."
	newdoc contrib/Contents contrib_Contents || die "newdoc failed."
}

pkg_postinst () {
	elog "Please view both the README and contrib_Contents files"
	elog "as you may want to adjust some settings and/or use"
	elog "contributed software. In the latter case you may need"
	elog "to extract some files from the ${P} distfile."
}
