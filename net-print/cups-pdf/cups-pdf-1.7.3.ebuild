# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/cups-pdf/cups-pdf-1.7.3.ebuild,v 1.1 2005/08/02 21:26:58 metalgod Exp $

DESCRIPTION="Provides a virtual printer for CUPS to produce PDF files."
HOMEPAGE="http://cip.physik.uni-wuerzburg.de/~vrbehr/cups-pdf/"
MY_P="${PN}_${PV}"
SRC_URI="http://cip.physik.uni-wuerzburg.de/~vrbehr/cups-pdf/src/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="net-print/cups
	virtual/ghostscript"

src_compile() {
	cd src
	gcc ${CFLAGS} -o cups-pdf cups-pdf.c || die "Compilation failed."
}

src_install () {
	dodir /usr/lib/cups/backend
	exeinto /usr/lib/cups/backend
	doexe src/cups-pdf

	dodir /usr/share/cups/model
	insinto /usr/share/cups/model
	doins extra/PostscriptColor.ppd.gz
}
